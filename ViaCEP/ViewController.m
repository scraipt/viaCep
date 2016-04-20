//
//  ViewController.m
//  ViaCEP
//
//  Created by Mario Santana on 4/18/16.
//  Copyright © 2016 Mario Santana. All rights reserved.
//

#import "ViewController.h"
#import "Reachability.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
 
    [super viewDidLoad];
    
    [_actvity setHidden:true];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(bool)returnInternetConectionStatus {
    Reachability *curReach = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    bool status = false;
    
    switch (netStatus){
        case NotReachable: {
            status = false;
            break;
        }
        case ReachableViaWWAN: {
            status = true;
            break;
        }
        case ReachableViaWiFi: {
            status = true;
            break;
        }
    }
    return status;
}

- (IBAction)btnConsultar:(id)sender {
    
        if ([self.txtCep.text length] == 0) {
        
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Atencao" message:@"Digite um cep valido" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
            
        } else {
   
    [_actvity setHidden:false];
    [_actvity startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self returnInternetConectionStatus]) {
                
                
                NSString *url = [NSString stringWithFormat:@"https://viacep.com.br/ws/%@/json/", _txtCep.text];
                
                
                NSData *json = [NSData dataWithContentsOfURL: [NSURL URLWithString:url]];
                
                NSError *erro;
                NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingMutableContainers error:&erro];
                
                
                
                if (!erro) {
                    _lblCep.text         = [resultado objectForKey:@"cep"];
                    _lblLogradouro.text  = [resultado objectForKey:@"logradouro"];
                    _lblComplemento.text = [resultado objectForKey:@"complemento"];
                    _lblBairro.text      = [resultado objectForKey:@"bairro"];
                    _lblLocalidade.text  = [resultado objectForKey:@"localidade"];
                }
            } else {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Atencao" message:@"nao foi localizado conexao" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction * ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alert addAction:ok];
                
                [self presentViewController:alert animated:YES completion:nil];
                
            }
            
            [_actvity stopAnimating];
            [_actvity setHidden:true];
            
            
        });
    });

        }
}

- (IBAction)btnLimpar:(id)sender {
   self.txtCep.text = @"";
    
}
@end
