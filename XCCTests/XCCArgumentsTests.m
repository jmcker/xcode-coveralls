/*******************************************************************************
 * The MIT License (MIT)
 * 
 * Copyright (c) 2014 Jean-David Gadina - www-xs-labs.com
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

#import "XCCArgumentsTests.h"
#import "XCC.h"

@implementation XCCArgumentsTests

- ( void )testEmptyArguments
{
    {
        XCCArguments * args;
        const char   * argv[] = { "" };
        
        args = [ [ XCCArguments alloc ] initWithArguments: argv count: 1 ];
        
        XCTAssertTrue( args.showHelp );
    }
}

- ( void )testInvalidArguments
{
    {
        XCCArguments * args;
        const char   * argv[] = { "" };
        
        args = [ [ XCCArguments alloc ] initWithArguments: argv count: 1 ];
        
        XCTAssertTrue( args.showHelp );
    }
}

- ( void )testShowHelp
{
    XCCArguments * args;
    const char   * argv[] = { "", "--help" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 2 ];
    
    XCTAssertTrue( args.showHelp );
}

- ( void )testVerbose
{
    XCCArguments * args;
    const char   * argv[] = { "", "--verbose" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 2 ];
    
    XCTAssertTrue( args.verbose );
}

- ( void )testBuildDirectory
{
    XCCArguments * args;
    const char   * argv[] = { "", "" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 2 ];
    
    XCTAssertFalse( args.showHelp );
}

- ( void )testInvalidGCov
{
    XCCArguments * args;
    const char   * argv[] = { "", "--gcov", "--verbose", "" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 4 ];
    
    XCTAssertTrue( args.showHelp );
    XCTAssertNil( args.gcov );
}

- ( void )testValidGCov
{
    XCCArguments * args;
    const char   * argv[] = { "", "--gcov", "", "" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 4 ];
    
    XCTAssertFalse( args.showHelp );
    XCTAssertNotNil( args.gcov );
}

- ( void )testInvalidIncludeDir
{
    XCCArguments * args;
    const char   * argv[] = { "", "--include", "--verbose", "" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 4 ];
    
    XCTAssertTrue( args.showHelp );
    XCTAssertEqual( 0, args.includedPaths.count );
}

- ( void )testValidIncludeDir
{
    XCCArguments * args;
    const char   * argv[] = { "", "--include", "", "" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 4 ];
    
    XCTAssertFalse( args.showHelp );
    XCTAssertGreaterThan( args.includedPaths.count, 0 );
}

- ( void )testInvalidExcludeDir
{
    XCCArguments * args;
    const char   * argv[] = { "", "--exclude", "--verbose", "" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 4 ];
    
    XCTAssertTrue( args.showHelp );
    XCTAssertEqual( 0, args.excludedPaths.count );
}

- ( void )testValidExcludeDir
{
    XCCArguments * args;
    const char   * argv[] = { "", "--exclude", "", "" };
    
    args = [ [ XCCArguments alloc ] initWithArguments: argv count: 4 ];
    
    XCTAssertFalse( args.showHelp );
    XCTAssertGreaterThan( args.excludedPaths.count, 0 );
}

@end
