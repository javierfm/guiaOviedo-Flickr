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
-(void)centrarMapaEnCoordenada:(CLLocationCoordinate2D) coordenada;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize masterPopoverController = _masterPopoverController;
@synthesize mapa,popOver;
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

   /* if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }*/
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
   
    CLLocationCoordinate2D coordenada;
    coordenada.latitude=43.3602994;
    coordenada.longitude=-5.844781;
    [self centrarMapaEnCoordenada:coordenada];
    
    [self obtenerLocalizaciones];
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

#pragma mark - Métodos del MKMapViewDelegate

//Configuro el diseño de las anotaciones en el mapa 
-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    MKPinAnnotationView *pin=nil;
    if([annotation class]==[miAnotacion class])
    {
        NSString *identificador=@"miTienda";
        pin=(MKPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:identificador];
        
        if(pin==nil)
        {
            pin=[[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identificador];
        }

        pin.annotation=annotation;
        pin.enabled=YES;
        
        UIButton *btnDetalle=[UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        btnDetalle.frame=CGRectMake(0, 0, 23, 23);
        btnDetalle.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
        btnDetalle.contentHorizontalAlignment=UIControlContentHorizontalAlignmentCenter;
        pin.rightCalloutAccessoryView=btnDetalle;
        pin.canShowCallout=YES;
    }
    return  pin;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    detalleLocalizacion *detalleLoc=[[detalleLocalizacion alloc]initWithNibName:@"detalleLocalizacion" bundle:nil];
    NSLog(@"1");
    
    self.popOver=[[UIPopoverController alloc]initWithContentViewController:detalleLoc];
     NSLog(@"2"); 
    [popOver setPopoverContentSize:CGSizeMake(320, 200) animated:YES];
      NSLog(@"3");
    [self.popOver presentPopoverFromRect:CGRectMake(mapView.bounds.origin.x+(mapView.bounds.size.width/2)-160, mapView.bounds.origin.y+(mapView.bounds.size.height/2)-100, 320, 200) inView:mapView permittedArrowDirections:NO animated:NO]; 
      NSLog(@"4");
}

#pragma mark - Metodos propios
-(void)centrarMapaEnCoordenada:(CLLocationCoordinate2D) coordenada{
    //creamos una varible con la region en la que se centrará el mapa
    MKCoordinateRegion region;
    //a esta region le asignamos la coordenada en la que se situará
    region.center =coordenada; 
    //asignamos ademas el nivel de zoom o detalle
    region.span.latitudeDelta =zoom_min;
    region.span.longitudeDelta=zoom_min;
    //hacemos que el mapa se centre en la region anterior de forma animada
    [mapa setRegion:region animated:TRUE];
}

-(void)obtenerLocalizaciones
{
    //Ruta de Productos.plist en el directorio de la app
    NSString *rutaProductos=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"localizaciones.plist"];
    
    //Si Productos.plist existe en esa ruta ...
    if ([[NSFileManager defaultManager] fileExistsAtPath:rutaProductos]) 
    {
        //Cargamos el contenido en un diccionario cuyas claves son las categorias
        NSDictionary *diccionario = [[NSDictionary alloc] initWithContentsOfFile:rutaProductos];
        [self guardarLocalizaciones:diccionario];
    }
    
    //Si Productos.plist NO existe
    else
    {
        //Ruta Productos.plist en nuestro proyecto
        NSString *rutaFicheroProyecto =[[NSBundle mainBundle] pathForResource:@"localizaciones" ofType:@"plist"];
        //Se crea un NSDictionary con el plist del proyecto y se copia en Documents
        NSDictionary *diccionario=[[NSDictionary alloc] initWithContentsOfFile:rutaFicheroProyecto];
        [diccionario writeToFile:rutaProductos atomically:YES];
        [self guardarLocalizaciones:diccionario];
        
    }
}

-(void)guardarLocalizaciones:(NSDictionary *)_localizaciones
{
    NSLog(@"Guardar loc");
    //Recogemos al array de categorias y productos el contenido del diccionario
    for(NSString *categoria in _localizaciones)
    {
        
            //Array de diccionarios en cada categoria. Por cada diccionario creo un objeto Producto
            NSArray *objetosxCategoria=[_localizaciones valueForKey:categoria];
            for(NSDictionary *objDict in objetosxCategoria)
            {
                CLLocationCoordinate2D coordenada;
                coordenada.latitude=[[objDict valueForKey:@"lat"]floatValue];
                coordenada.longitude=[[objDict valueForKey:@"long"]floatValue];
                
                miAnotacion *nA=[[miAnotacion alloc]initWithCoordenada:coordenada titulo:[objDict valueForKey:@"Nombre"] subtitulo:categoria];
                [self.mapa addAnnotation:nA];
                NSLog(@"Anotando %f titulo: %@",[[objDict valueForKey:@"lat"]floatValue],[objDict valueForKey:@"Nombre"]);
            }

    }

}

-(IBAction)vistaSatelite:(id)sender
{
    switch ([sender selectedSegmentIndex]) {
        case 0:
            self.mapa.mapType=MKMapTypeSatellite;
            break;
        default:
             self.mapa.mapType=MKMapTypeStandard;
            break;
    }
    /*//if((UIBarButtonItem*)sender
    if (self.mapa.mapType==MKMapTypeStandard)
    {
        self.mapa.mapType=MKMapTypeSatellite;
        [(UIBarButtonItem*)sender setTitle:@"Vista normal"];
    }
    else
    {
        self.mapa.mapType=MKMapTypeStandard;
        [(UIBarButtonItem*)sender setTitle:@"Vista satélite"];
    }*/
}

-(IBAction)variarZoom:(id)sender
{
    MKCoordinateRegion region;
    //a esta region le asignamos la coordenada en la que se situará
    region.center =self.mapa.region.center; 
    
   switch ([sender selectedSegmentIndex]) {
        case 0:
            //asignamos ademas el nivel de zoom o detalle
            region.span.latitudeDelta =zoom_min;
            region.span.longitudeDelta=zoom_min;
            break;
        case 1:
            region.span.latitudeDelta =zoom_norm;
            region.span.longitudeDelta=zoom_norm;
            break;
        case 2:
            region.span.latitudeDelta =zoom_max;
            region.span.longitudeDelta=zoom_max;
            break;
    }
    

    [mapa setRegion:region animated:TRUE];
}

#pragma mark - Application's Documents directory

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
