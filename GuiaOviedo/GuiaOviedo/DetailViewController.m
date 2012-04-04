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
@synthesize mapa,controladorPopover;
#pragma mark - Managing the detail item

-(IBAction)mostrar:(id)sender{
    if(controladorPopover){
        [controladorPopover dismissPopoverAnimated:YES];
        controladorPopover=nil;
    }else{
        ControladorDetalle *a=[[ControladorDetalle alloc]init];
        controladorPopover= [[UIPopoverController alloc] initWithContentViewController:a];
        [controladorPopover presentPopoverFromBarButtonItem:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
    }
}

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

#pragma mark - MKMapView


#pragma mark - Metodos propios
-(void)centrarMapaEnCoordenada:(CLLocationCoordinate2D) coordenada{
    //creamos una varible con la region en la que se centrará el mapa
    MKCoordinateRegion region;
    //a esta region le asignamos la coordenada en la que se situará
    region.center =coordenada; 
    //asignamos ademas el nivel de zoom o detalle
    region.span.latitudeDelta =.003;
    region.span.longitudeDelta=.003;
    //hacemos que el mapa se centre en la region anterior de forma animada
    [mapa setRegion:region animated:TRUE];
}


@end
