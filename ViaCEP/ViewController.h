//
//  ViewController.h
//  ViaCEP
//
//  Created by Mario Santana on 4/18/16.
//  Copyright © 2016 Mario Santana. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *actvity;
- (IBAction)btnConsultar:(id)sender;
-(bool)returnInternetConectionStatus;
@property (weak, nonatomic) IBOutlet UITextField *txtCep;
- (IBAction)btnLimpar:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *lblCep;
@property (weak, nonatomic) IBOutlet UILabel *lblLogradouro;
@property (weak, nonatomic) IBOutlet UILabel *lblComplemento;
@property (weak, nonatomic) IBOutlet UILabel *lblBairro;
@property (weak, nonatomic) IBOutlet UILabel *lblLocalidade;

@end

