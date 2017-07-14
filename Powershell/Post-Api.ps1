#json example
$body = @{
    From = 'test@email.com';
    To = "john.moss@email.co.uk";
    Body = "<p>This is a test email</p>";
    Subject = 'Test';   
    Attachments =$null;   
}

$url = 'https://localhost:5011/api/mail/send'

Invoke-RestMethod -URI $url -Method Post -Body (ConvertTo-Json $body) -ContentType "text/json" 

# Sample with attachements
$body2 = @{
    From = 'test@email.com';
    To = "john.moss@email.co.uk";
    Body = "<p>This is a test email</p>";
    Subject = 'Test';   
    Attachments = @(
      @{
            Name = "Attachement1.txt";
            Base64EncodedFile = "dGhlIHF1aWNrIGJyb3duIGZveCBldGM=";
            MimeType = "text/plain";
      })
}
