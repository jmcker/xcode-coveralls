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

#import <Foundation/Foundation.h>
#import <clang-warnings.h>

@class XCCArguments;

@interface XCCGCovFile: NSObject

@property( atomic, readonly ) NSString     * path;
@property( atomic, readonly ) NSString     * sourcePath;
@property( atomic, readonly ) NSString     * name;
@property( atomic, readonly ) NSString     * graphPath;
@property( atomic, readonly ) NSString     * dataPath;
@property( atomic, readonly ) NSUInteger     runs;
@property( atomic, readonly ) NSUInteger     programs;
@property( atomic, readonly ) NSArray      * lines;
@property( atomic, readonly ) NSString     * jsonRepresentation;
@property( atomic, readonly ) NSDictionary * dictionaryRepresentation;

- ( instancetype )initWithPath: ( NSString * )path;
- ( instancetype )initWithPath: ( NSString * )path arguments: ( XCCArguments * )args NS_DESIGNATED_INITIALIZER;

@end
