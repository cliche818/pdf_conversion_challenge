# Hubdoc Document Intake

## Background:

Hubdoc's customers upload millions of financial documents (receipts,
statements, invoices, etc...) each month. Having the documents themselves is
useful, and being able to identify key pieces of information within those
documents is even more useful.

### Your task is to implement a service that does the following:

* Exposes an HTTP endpoint, `/upload`
  * e.g. `curl -F 'file=@"invoices/HubdocInvoice1.pdf"' -F
    'email=user@domain.com' localhost:3000/upload`
  * Accepts a .pdf document and a user email in the body of the request
  * Attempts to extract the following data from the document
    * *Vendor* (e.g. Starbucks, Home Depot, McDonalds)
    * *Invoice Date* 
    * *Invoice Amount* (a positive or negative value with at most 2 decimal
      places)
    * *Currency* (a three character currency code; e.g. CAD, GBP)
    * *Tax* (a positive or negative value with at most 2 decimal places)
  * Responds with a JSON payload containing an assigned document id:
  ```javascript
  { 
    id: <someUniqueId>
  }
  ```
* Exposes an HTTP endpoint, `/document/:id` 
  * `curl -XGET http://localhost:3000/document/:id` 
  * Respond with the following payload: 
  ```javascript 
  { 
    uploadedBy : '<userEmailAddress>',
    uploadTimestamp : '<timestamp>',
    filesize: '<filesize>',
    vendorName: '<vendorName>',
    invoiceDate: '<invoiceDate>',
    amountDue: '<amountDue>',
    currency: '<currency>',
    taxAmount: '<taxAmount>',
    processingStatus: '<status>',
  }
  ```
    * If you are unable to successfully extract a given field, you can set the
      response value to `null` or `undefined`.
    * The only fields that must always have a value are `uploadedBy` and
      `uploadTimestamp`

We have provided some bootstrap code that can accept a file upload. This
template uses the following tech stack:

* Node 10 or greater
* Express 4.x
* Multer

Within this package, you will find an `invoices` folder that contains a set of
Hubdoc invoices. Your service should correctly extract the expected fields from
all supplied invoices.

Your service should also successfully process invoices from multiple concurrent
users.

While you are free to use whatever stack you'd like, we recommend you use
`pdftotext` to extract text from pdf documents.  If you do use `pdftotext` or
another tool installed outside of your required modules, please make sure to
tell us the version required.

* https://linux.die.net/man/1/pdftotext
* Linux and Mac users can use `brew` or `apt-get`
* Windows users can find the relevant binaries here
  * http://www.xpdfreader.com/download.html

Although Hubdoc's codebase is primarily written in JS, you are not required to
use any of the above tools or any of the provided code. Feel free to work with
any languages or frameworks you are comfortable with. 

## We expect the following from you:

* Working code that accomplishes the task outlined above.
* Corresponding tests (unit and integration tests are both acceptable).

## We do NOT expect you to worry about the following:

* User authentication or any other form of endpoint security
  * *For senior candidates we may ask how you would accomplish this, but we
    don't expect to see code here*
* Virus checking or document format validation (i.e. you can assume we will
  send you valid pdfs)

# Jeff Documentations
## setup
used ruby version 2.6.3 to develop
run bundle install
for unit/integration tests: rails test
to run the server: rails s (will be available at localhost:3000 by default)
 
To try run (in the project root directory): 
curl -F 'file=@"invoices/HubdocInvoice1.pdf"' -F 'email=user@domain.com' localhost:3000/upload

expected behaviour:
- HubdocInvoice1.pdf shows up in /file_storage/HubdocInvoice1.pdf
- a record in the sqlite table (can be seen in rails c -> Invoice.last)

To see the newly created record can also do localhost:3000/document/1 (assuming first record created)

## PDF to text spike
1) https://github.com/yob/pdf-reader
2) https://github.com/benbalter/pdftotext

2 requires installing poppler on my Mac, 1 just works out of the box.  Both returns a string representing the PDF.
1 is also maintained, unlike 2 (the wrapper is not maintained anymore).  I will go with 1.

## /upload
Does not check if there are duplicates.  
It will create a new record in the invoices table and overwrite the file that is already there.
For processing_status, there could be more (i.e error, initialized), but for now there is only "success".
pdf_string_converter.rb is responsible for converting pdf to string.
invoice_extractor.rb is responsible for getting the raw values out of the invoice string.

Did not have time to get the mocking library working or would have included tests that mocked the following: 
-FileUtils.mv
-PdfStringConverter.to_string
-InvoiceExtracter.to_invoice 

## /document/:id
have controller tests in upload_controller_test.rb

## Things to do
- figure out how to mock (could switch to RSpec or use the Mocha gem)

Future features:
- PDF info extraction can be a background job (i.e use Sidekiq)
 

