# Scrapbook
Bits and pieces

## Machine Setup

The *MachineSetup.ps1* file can be used to bootstrap basic apps using chocolatey. Execute from windows command prompt as shown below:

```
Set-ExecutionPolicy AllSigned; 
iex ((New-Object System.Net.WebClient).DownloadString('https://bit.ly/mos7624'))
```

## Markdown Sample
A simple markdown preview using Showdown an Xss filter extension and the xssjs library
* [showdown](https://github.com/showdownjs/showdown)
* [showdown-xss-filter](https://github.com/VisionistInc/showdown-xss-filter)
* [jsxss](http://jsxss.com/en/index.html)
