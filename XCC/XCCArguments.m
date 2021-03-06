/*******************************************************************************
 * The MIT License (MIT)
 * 
 * Copyright (c) 2015 Jean-David Gadina - www-xs-labs.com
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 ******************************************************************************/

#import "XCCArguments.h"

@interface XCCArguments()

@property( atomic, readwrite, assign ) BOOL       showHelp;
@property( atomic, readwrite, assign ) BOOL       showVersion;
@property( atomic, readwrite, assign ) BOOL       verbose;
@property( atomic, readwrite, assign ) BOOL       dryRun;
@property( atomic, readwrite, strong ) NSArray  * buildDirectories;
@property( atomic, readwrite, strong ) NSString * gcov;
@property( atomic, readwrite, strong ) NSArray  * excludedPaths;
@property( atomic, readwrite, strong ) NSArray  * includedPaths;
@property( atomic, readwrite, strong ) NSString * project;
@property( atomic, readwrite, assign ) NSUInteger jobID;
@property( atomic, readwrite, strong ) NSString * service;
@property( atomic, readwrite, strong ) NSString * token;

@end

@implementation XCCArguments

- ( instancetype )init
{
    const char * argv[ 1 ] = { "" };
    
    return [ self initWithArguments: argv count: 1 ];
}

- ( instancetype )initWithArguments: ( const char ** )arguments count: ( NSUInteger )count
{
    NSUInteger       i;
    NSMutableArray * excPaths;
    NSMutableArray * incPaths;
    NSMutableArray * buildDirectories;
    NSString       * arg;
    NSString       * value;
    BOOL             valid;
    BOOL             hasJobID;
    
    if( ( self = [ super init ] ) )
    {
        excPaths         = [ NSMutableArray new ];
        incPaths         = [ NSMutableArray new ];
        buildDirectories = [ NSMutableArray new ];
        valid            = NO;
        hasJobID         = NO;
        
        if( count < 2 )
        {
            self.showHelp = YES;
            
            goto end;
        }
        
        for( i = 1; i < count; i++ )
        {
            arg = [ NSString stringWithCString: arguments[ i ] encoding: NSUTF8StringEncoding ];
            
            if( [ arg hasPrefix: @"--" ] )
            {
                if( buildDirectories.count > 0 )
                {
                    valid = NO;
                    
                    break;
                }
                
                if( [ arg isEqualToString: @"--version" ] )
                {
                    self.showVersion = YES;
                }
                else if( [ arg isEqualToString: @"--help" ] )
                {
                    self.showHelp = YES;
                }
                else if( [ arg isEqualToString: @"--verbose" ] )
                {
                    self.verbose = YES;
                }
                else if( [ arg isEqualToString: @"--dry-run" ] )
                {
                    self.dryRun = YES;
                }
                else if( [ arg isEqualToString: @"--gcov" ] )
                {
                    if( i == count - 1 )
                    {
                        break;
                    }
                    
                    value = [ NSString stringWithCString: arguments[ ++i ] encoding: NSUTF8StringEncoding ];
                    
                    if( [ value hasPrefix: @"--" ] )
                    {
                        break;
                    }
                    
                    self.gcov = value;
                }
                else if( [ arg isEqualToString: @"--include" ] )
                {
                    if( i == count - 1 )
                    {
                        break;
                    }
                    
                    value = [ NSString stringWithCString: arguments[ ++i ] encoding: NSUTF8StringEncoding ];
                    
                    if( [ value hasPrefix: @"--" ] )
                    {
                        break;
                    }
                    
                    [ incPaths addObject: value ];
                }
                else if( [ arg isEqualToString: @"--exclude" ] )
                {
                    if( i == count - 1 )
                    {
                        break;
                    }
                    
                    value = [ NSString stringWithCString: arguments[ ++i ] encoding: NSUTF8StringEncoding ];
                    
                    if( [ value hasPrefix: @"--" ] )
                    {
                        break;
                    }
                    
                    [ excPaths addObject: value ];
                }
                else if( [ arg isEqualToString: @"--project" ] )
                {
                    if( i == count - 1 )
                    {
                        break;
                    }
                    
                    value = [ NSString stringWithCString: arguments[ ++i ] encoding: NSUTF8StringEncoding ];
                    
                    if( [ value hasPrefix: @"--" ] )
                    {
                        break;
                    }
                    
                    self.project = value;
                }
                else if( [ arg isEqualToString: @"--id" ] )
                {
                    hasJobID = YES;
                    
                    if( i == count - 1 )
                    {
                        break;
                    }
                    
                    value = [ NSString stringWithCString: arguments[ ++i ] encoding: NSUTF8StringEncoding ];
                    
                    if( [ value hasPrefix: @"--" ] )
                    {
                        break;
                    }
                    
                    self.jobID = ( NSUInteger )[ value integerValue ];
                }
                else if( [ arg isEqualToString: @"--service" ] )
                {
                    if( i == count - 1 )
                    {
                        break;
                    }
                    
                    value = [ NSString stringWithCString: arguments[ ++i ] encoding: NSUTF8StringEncoding ];
                    
                    if( [ value hasPrefix: @"--" ] )
                    {
                        break;
                    }
                    
                    self.service = value;
                }
                else if( [ arg isEqualToString: @"--token" ] )
                {
                    if( i == count - 1 )
                    {
                        break;
                    }
                    
                    value = [ NSString stringWithCString: arguments[ ++i ] encoding: NSUTF8StringEncoding ];
                    
                    if( [ value hasPrefix: @"--" ] )
                    {
                        break;
                    }
                    
                    self.token = value;
                }
            }
            else
            {
                [ buildDirectories addObject: arg ];
                
                valid = YES;
            }
        }
        
        end:
        
        self.excludedPaths = [ NSArray arrayWithArray: excPaths ];
        self.includedPaths = [ NSArray arrayWithArray: incPaths ];
        
        if( valid == NO )
        {
            self.showHelp = YES;
        }
        else
        {
            self.buildDirectories = [ NSArray arrayWithArray: buildDirectories ];
            
            if( hasJobID == NO )
            {
                {
                    NSString * travisBuild;
                    
                    travisBuild = [ [ [ NSProcessInfo processInfo ]environment ] objectForKey: @"TRAVIS_JOB_ID" ];
                    self.jobID  = ( NSUInteger )[ travisBuild integerValue ];
                }
            }
            
            if( self.service == nil )
            {
                self.service = @"travis-ci";
            }
        }
    }
    
    return self;
}

@end
