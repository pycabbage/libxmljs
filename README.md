# Libxmljs

Build Status: [![Upload Assets to GitHub](https://github.com/pycabbage/libxmljs/actions/workflows/upload-assets.yml/badge.svg)](https://github.com/pycabbage/libxmljs/actions/workflows/upload-assets.yml)  
fork of [libxmljs/libxmljs](https://github.com/libxmljs/libxmljs)

LibXML bindings for [node.js](http://nodejs.org/)

## Installation

```bash
npm install git+https://github.com/pycabbage/libxmljs.git
```

## Usage

```javascript
const libxmljs = require("libxmljs");
const xml =  '<?xml version="1.0" encoding="UTF-8"?>' +
           '<root>' +
               '<child foo="bar">' +
                   '<grandchild baz="fizbuzz">grandchild content</grandchild>' +
               '</child>' +
               '<sibling>with content!</sibling>' +
           '</root>';

const xmlDoc = libxmljs.parseXml(xml);

// xpath queries
const gchild = xmlDoc.get('//grandchild');

console.log(gchild.text());  // prints "grandchild content"

const children = xmlDoc.root().childNodes();
const child = children[0];

console.log(child.attr('foo').value()); // prints "bar"
```

## Support

* Docs - [http://github.com/libxmljs/libxmljs/wiki](http://github.com/libxmljs/libxmljs/wiki)
* Mailing list - [http://groups.google.com/group/libxmljs](http://groups.google.com/group/libxmljs)

## API and Examples

Check out the wiki [http://github.com/libxmljs/libxmljs/wiki](http://github.com/libxmljs/libxmljs/wiki).

See the [examples](https://github.com/libxmljs/libxmljs/tree/master/examples) folder.

<!-- ## Installation via [npm](https://npmjs.org)

```shell
npm install libxmljs
``` -->

## Contribute

Start by checking out the [open issues](https://github.com/libxmljs/libxmljs/issues?labels=&page=1&state=open). Specifically the [desired feature](https://github.com/libxmljs/libxmljs/issues?labels=desired+feature&page=1&state=open) ones.

### Requirements

Make sure you have met the requirements for [node-gyp](https://github.com/TooTallNate/node-gyp#installation). You DO NOT need to manually install node-gyp; it comes bundled with node.
