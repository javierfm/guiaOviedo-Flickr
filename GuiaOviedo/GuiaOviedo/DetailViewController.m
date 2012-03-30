//
//  DetailViewController.m
//  GuiaOviedo
//
//  Created by svp on 30.03.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize listadoFotos,datosInternet;

#pragma mark - Métodos del NSURLConnectionDelegate

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [self.datosInternet setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.datosInternet appendData:data];//Se van añadiendo datos
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self serializar];//Serializamos los resultados obtenidos del JSON
    NSLog(@"%@",self.datosInternet);
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",[error localizedDescription]);
}

#pragma mark - Métodos del controlador

- (void)serializar {
    
    NSError* error;
    NSDictionary* resultado = [NSJSONSerialization 
                                    JSONObjectWithData:self.datosInternet
                                    options:kNilOptions
                                    error:&error];
    
    NSArray *fotos=[[resultado objectForKey:@"photos"]objectForKey:(@"photo")];
    
    for(NSDictionary *foto in fotos)
    {
        Fotografia *f=[[Fotografia alloc]init];
        
        f.titulo=@"f";
        
        /*La url se consigue con las propiedades que obtenemos del JSON:
        //http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        */
        
        NSString *url=[NSString stringWithFormat:@"http://farm%@.staticflickr.com/%@/%@_%@.jpg",
                      [foto valueForKey:@"farm"],
                      [foto valueForKey:@"server"],
                      [foto valueForKey:@"id"],
                      [foto valueForKey:@"secret"]];
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    self.listadoFotos=[[NSMutableArray alloc]initWithCapacity:0];
    
    NSMutableURLRequest *peticionFotos=[NSURLRequest requestWithURL:URLServicio];
    
    //Pido las fotos que cumplan los requisitos:tag:oviedo,geolocalizadas,accurcy:city
    NSURLConnection *conexionPedirFotos=[[NSURLConnection alloc]initWithRequest:peticionFotos delegate:self];
    
    if(conexionPedirFotos)
    {
        self.datosInternet=[NSMutableData data];//Objeto que guardará los datos
    }
    else
    {
        NSLog(@"La conexión no se ha podido realizar");
    }    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
