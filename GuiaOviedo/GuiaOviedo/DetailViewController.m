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
    NSDictionary* fotosObtenidas = [NSJSONSerialization 
                                    JSONObjectWithData:self.datosInternet
                                    options:kNilOptions
                                    error:&error];
    
    NSArray *resultado=[fotosObtenidas objectForKey:@"photos"];//Diccionario con todos los resultados
    
    for(NSDictionary *dic in resultado)
    {
        
        //URL de la tienda
        CLLocationCoordinate2D coordenadas;
        coordenadas.latitude=[[dic valueForKeyPath:@"geometry.location.lat"] floatValue];
        coordenadas.longitude=[[dic valueForKeyPath:@"geometry.location.lng"] floatValue];
        
        //Creo un objeto de la clase miAnotacion que implmenta el protocolo MKAnnotation
        miAnotacion *anotacion=[[miAnotacion alloc]initWithCoordenada:coordenadas titulo:[dic valueForKey:@"name"] subtitulo:[dic valueForKey:@"vicinity"]];
        [self.tiendas addObject:anotacion];
        
        for (miAnotacion *an in self.tiendas) 
        {
            [self.mapa addAnnotation:an];//Añado las anotaciones en el mapa
        }
    }
    
    //Paro el indicador
    if([self.indicador isAnimating])
    {
        [self.indicador stopAnimating];
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
