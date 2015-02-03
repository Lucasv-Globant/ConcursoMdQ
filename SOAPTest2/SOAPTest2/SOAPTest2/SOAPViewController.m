//
//  SOAPViewController.m
//  SOAPTest2
//
//  Created by Lucas on 1/27/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "SOAPViewController.h"


@interface SOAPViewController ()
@property (strong, nonatomic) IBOutlet UITextField *txtLatitud;
@property (strong, nonatomic) IBOutlet UITextField *txtLongitud;
@property (strong, nonatomic) IBOutlet UITextField *txtDistancia;

@end

@implementation SOAPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)btnFetchTap:(id)sender {
    [self fetchXMLDocument];
}

-(void)goToBeachesViewController
{
    
    if ([self.articles count] > 0)
    {
        BeachesViewController *beachesVC = [[BeachesViewController alloc] initWithNibName:@"BeachesViewController" bundle:nil];
    
        beachesVC.elements = self.articles;
        beachesVC.latitud = [[self txtLatitud] text];
        beachesVC.longitud = [[self txtLongitud] text];
        beachesVC.distancia = [[self txtDistancia] text];
        [self.navigationController pushViewController:beachesVC animated:YES];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"La consulta de playas no devolvió resultados" delegate:self cancelButtonTitle:@"Aceptar" otherButtonTitles:nil];
        [alert show];
    }
    
}

-(void)fetchXMLDocument
{
        self.articles = [[NSMutableArray alloc] init];
        self.errorParsing=NO;

        NSString *rawBody = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:open=\"http://192.168.0.235/opendata\"><soapenv:Header/>                               <soapenv:Body><open:playas soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><latitud xsi:type=\"xsd:string\">%@</latitud>                                <longitud xsi:type=\"xsd:string\">%@</longitud>                                <distanciamaxima xsi:type=\"xsd:string\">%@</distanciamaxima>                                <cantidadmaxima xsi:type=\"xsd:string\">1000</cantidadmaxima>                                <token xsi:type=\"xsd:string\">wwfe345gQ3ed5T67g4Dase45F6fer</token>                                </open:playas></soapenv:Body></soapenv:Envelope>",self.txtLatitud.text,self.txtLongitud.text, self.txtDistancia.text];
    

    
        NSString* body = [rawBody stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
        NSString *string = @"http://gisdesa.mardelplata.gob.ar/opendata/ws.php/playas";
        NSURL *url = [NSURL URLWithString:string];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        
        AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
        [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
        request.HTTPMethod = @"POST";
        [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    
    
        // Make sure to set the responseSerializer correctly
        operation.responseSerializer = [AFXMLParserResponseSerializer serializer];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSXMLParser *XMLParser = (NSXMLParser *)responseObject;
            [XMLParser setShouldProcessNamespaces:YES];
            NSLog(@"Raw XML Data: %@", [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding]);
            // Leave these commented for now (you first need to add the delegate methods)
             XMLParser.delegate = self;
             [XMLParser parse];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                                message:[error localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
            
        }];
        
        [operation start];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"File found and parsing started");
    
}

- (void)parseXMLFileAtURL:(NSString *)URL
{
    
    NSString *agentString = @"Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_5_6; en-us) AppleWebKit/525.27.1 (KHTML, like Gecko) Version/3.2.1 Safari/525.27.1";
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:
                                    [NSURL URLWithString:URL]];
    [request setValue:agentString forHTTPHeaderField:@"User-Agent"];
    
    
    NSString *yourPostString = [NSString stringWithFormat:@"<soapenv:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:open=\"http://192.168.0.235/opendata\"><soapenv:Header/>                               <soapenv:Body><open:playas soapenv:encodingStyle=\"http://schemas.xmlsoap.org/soap/encoding/\"><latitud xsi:type=\"xsd:string\">-38.011090</latitud>                                <longitud xsi:type=\"xsd:string\">-57.535371</longitud>                                <distanciamaxima xsi:type=\"xsd:string\">10</distanciamaxima>                                <cantidadmaxima xsi:type=\"xsd:string\">1000</cantidadmaxima>                                <token xsi:type=\"xsd:string\">wwfe345gQ3ed5T67g4Dase45F6fer</token>                                </open:playas></soapenv:Body></soapenv:Envelope>"];
    
    
    
    NSString *postLength =  [NSString stringWithFormat:@"%d", (int)[yourPostString length]];
    
    [request setHTTPBody:[yourPostString dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    self.articles = [[NSMutableArray alloc] init];
    self.errorParsing=NO;
    
    NSData *xmlFile = [ NSURLConnection sendSynchronousRequest:request returningResponse: nil error: nil ];
    
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithData:xmlFile];
    [rssParser setDelegate:self];
    
    // You may need to turn some of these on depending on the type of XML file you are parsing
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
    
    [rssParser parse];
    
}


- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    
    NSString *errorString = [NSString stringWithFormat:@"Error code %li", (long)[parseError code]];
    NSLog(@"Error parsing XML: %@", errorString);
    NSLog(@"The description is: %@",[parseError description]);
    
    self.errorParsing=YES;
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    self.currentElement = [elementName copy];
    self.ElementValue = [[NSMutableString alloc] init];
    if ([elementName isEqualToString:@"item"]) {
        self.item = [[NSMutableDictionary alloc] init];
        
    }
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    [self.ElementValue appendString:string];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if ([elementName isEqualToString:@"item"]) {
        [self.articles addObject:[self.item copy]];
    } else {
        [self.item setObject:self.ElementValue forKey:elementName];
    }
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
    if (self.errorParsing == NO)
    {
        NSLog(@"XML processing done!");
        [self goToBeachesViewController];
    } else {
        NSLog(@"Error occurred during XML processing");
    }
    
}

@end
