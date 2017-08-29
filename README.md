# multipart-js

https://github.com/isaacs/multipart-js

TPC: we should probably stop using this module - there are lots of legitimate alternatives.  This module hasn't been updated in six years and the test directory has the following in its last commit:
"support for nested params. Tests arent passing, some issue with boundaries"

TPC: here is the error when we run the tests locally using the now committed ./scripts/runtest.sh

Error: Malformed: boundary not found at start of message
    at error (/Users/tcassidy/kbm-devspc/git/multipart-js/lib/utils.js:6:19)
    at Parser.write (/Users/tcassidy/kbm-devspc/git/multipart-js/lib/parse.js:75:13)
    at Writer.writer.onData (/Users/tcassidy/kbm-devspc/git/multipart-js/test/write.js:116:10)
    at emit (/Users/tcassidy/kbm-devspc/git/multipart-js/lib/utils.js:11:31)
    at Writer.partBegin (/Users/tcassidy/kbm-devspc/git/multipart-js/lib/write.js:127:3)
    at Object.<anonymous> (/Users/tcassidy/kbm-devspc/git/multipart-js/test/write.js:125:8)
    at Module._compile (module.js:570:32)
    at Object.Module._extensions..js (module.js:579:10)
    at Module.load (module.js:487:32)
    at tryModuleLoad (module.js:446:12)



A JavaScript library for parsing and writing multipart messages.

## Current State

Pre-pre-alpha.  Almost nothing is here, and what is here is likely completely broken.

If you are asking about this, you probably ought to check out Felix's
[node-formidable](https://github.com/felixge/node-formidable) library.

## Usage

If you're familiar with [sax-js](http://github.com/isaacs/sax-js), then most of this should
be pretty straightforward.  Attach event handlers, call functions, close it when you're
done.  Please keep fingers and dangling clothing away from the state machine.

    var multipart = require("multipart");
    
    // parsing
    var parser = multipart.parser();
    
    // in all event handlers, "this" is the parser, and "this.part" is the
    // part that's currently being dealt with.
    parser.onpartbegin = function (part) { doSomething(part) };
    parser.ondata = function (chunk) { doSomethingElse(chunk) };
    parser.onend = function () { closeItUp() };
    
    // now start feeding the message through it.
    // you can do this all in one go, if you like, or one byte at a time,
    // or anything in between.
    parser.boundary = "foo";
    var chunk;
    while ( chunk = upstreamThing.getNextChunk() ) {
      parser.write(chunk);
    }
    parser.close();
    
    
    // writing
    var writer = multipart.writer();
    
    // attach event handlers for the things we care about.
    writer.ondata = function (chunk) { doSomething(chunk) };
    writer.onend = function () { closeItUp() };
    
    // now trigger the events to fire by feeding files through it.
    writer.boundary = "foo";
    writer.partBegin({ "content-type" : "text/plain", filename : "foo.txt" });
    var chunk;
    while ( chunk = getChunkOfFile() ) {
      writer.write(chunk);
    }
    writer.partEnd();
    writer.close();
