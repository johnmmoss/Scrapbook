
# Its possible to copy files using the standard cmd alias command:

copy source-file.txt destination-file.txt

# However, for big files, can leave the command line hanging for ages...
# To get a progress bar, use Bits...
# Although the ui still hangs, this results in a nice progress bar which shows perctange complete..

Import-Module BitsTransfer

Start-BitsTransfer -Source .\source-file.txt -Destination .\source-file.txt -Description "Copying file x to file y" -DisplayName "Copying file..."
