// Copyright (c) 2016 Bugsnag, Inc. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall remain in place
// in this source code.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

class AnotherClass: NSObject {

    func crash() {
        crash2()
    }

    func crash2() {
        makingAStackTrace() {
            let objC = AnObjCClass()
            objC.makeAStackTrace(self)
        }
    }

    func makingAStackTrace(block: () -> ()) {
        block()
    }

    func crash3() {
        Bugsnag.notify(NSException(name: "Test error", reason: "Testing if this works", userInfo: nil))
    }

    class func httpGetBad(url: NSURL, completionHandler: ((response: NSURLResponse?, data: NSData?, error: NSError?) -> Void)?) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            if let callback = completionHandler {
                callback(response: response, data: data, error: error) 
            }
        }
        task.resume()
    }

    class func httpGetGood(url: NSURL, completionHandler: (response: NSURLResponse?, data: NSData?, error: NSError?) -> Void) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            let callback = completionHandler
            callback(response: response, data: data, error: error)
        }
        task.resume()
    }
}
