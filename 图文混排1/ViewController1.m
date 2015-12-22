//
//  ViewController1.m
//  图文混排1
//
//  Created by ZhangCheng on 14-1-2.
//  Copyright (c) 2014年 ZhangCheng. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
#define WID 320
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString*str=@"1. Before we start our first lab, I'd like to tell you a ｛#1｝ bit about the workbook we'll be using.The first thing I'd like to point out is that the workbook contains a very large amount of material -- far more than you could ever ｛#2｝ in a single semester.What you're supposed to do is choose the｛#3｝  and activities that you want to do -- within a certain framework, of course. Part of my job is to help you make your ｛#4｝.Next, I'd like to mention that in each workbook ｛#5｝, there are usually two subsections.The first is called  and the second is called .In the  section, the workbook gives full｛#6｝for all the experiments, including alternate procedures.Choose the procedure you wish --- there's plenty of equipment｛#7｝.In the  section, you will find suggestions for projects that you can do on your own time.You'll see that there are usually no ｛#8｝ instructions for the activities –you're ｛#9｝ to do them your own way.If there are no ｛#10｝, let's turn to Chapter One now. ";
    
    
       NSMutableArray*mutableArray=[[NSMutableArray alloc]init];
    
   
    for (int a=1; a<=10; a++) {
        NSString*str=[NSString stringWithFormat:@"｛#%d｝",a];
        //获得切割目标对象
        [mutableArray addObject:str];
        
    }
    NSMutableArray*mubiaoArray=[[NSMutableArray alloc]init];
    
    for (int x=0; x<10; x++) {
        //切割10次，把{#}全切出来
         NSArray*array=[str componentsSeparatedByString:[mutableArray objectAtIndex:x]];
        
     [mubiaoArray addObject:[array objectAtIndex:0]];
        
        str=[array objectAtIndex:1];
    }
    
    NSLog(@"%@",mubiaoArray);
    int x=0;
    int y=0;
#define FONT 16
    BOOL isWidth;
    int i=0;
    for (NSString *str1 in mubiaoArray) {
        
         NSMutableString*str=[NSMutableString stringWithString:str1];
        CGSize xx=  [str sizeWithFont:[UIFont boldSystemFontOfSize:FONT] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        if (x+xx.width<WID) {
            UILabel*lable=[[UILabel alloc]initWithFrame:CGRectMake(x, y, xx.width,30)];
            lable.text=str;
            [self.view addSubview:lable];
            [lable release];
            x=x+xx.width;
        }else{
        
            isWidth = YES;
        
            int  hangshu= ((x+xx.width)/WID)/1;
            for (int a=0; a<=hangshu; a++) {
                  NSString * string = [self changeLine:str length:WID withFont:FONT];
                
                CGSize xx=  [string sizeWithFont:[UIFont boldSystemFontOfSize:FONT] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
                
                UILabel*label1=[[UILabel alloc]initWithFrame:CGRectMake(x, y, xx.width, 30)];
                label1.adjustsFontSizeToFitWidth = YES;
                label1.font = [UIFont systemFontOfSize:FONT];
                label1.backgroundColor = [UIColor clearColor];
                label1.numberOfLines=0;
                if (a  ==hangshu){
                    x+=xx.width;
                }else{
                
                  x=0;
                y+=30;

                }
                          
                label1.text=string;
                [self.view addSubview:label1];
                NSRange Range;
                Range=[str rangeOfString:string];
                //Range.length;
                NSLog(@"%d--%d",str.length,string.length);
                if (string.length>0) {
                   [str deleteCharactersInRange:Range];
                }

            }
            
        
        
        }//
        
        
        NSLog(@"%d----%d",x,y);
        
        if (x+60>WID) {
            y+=30;
            x=0;
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame=CGRectMake(x, y+10, 100, 10);
            [btn setTitle:@"按钮" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=i;
            [self.view addSubview:btn];
            
//            UISegmentedControl*seg=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"11",@"22",@"33", nil]];
//            seg.frame=CGRectMake(x, y+10, 100, 10);
//            [self.view addSubview:seg];
            x+=100;
            
            
        }else{
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            btn.frame=CGRectMake(x, y+10, 100, 10);
            [btn setTitle:@"按钮" forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag=i;
            [self.view addSubview:btn];

            
            
//            UISegmentedControl*seg=[[UISegmentedControl alloc]initWithItems:[NSArray arrayWithObjects:@"11",@"22",@"33", nil]];
//            seg.frame=CGRectMake(x, y+10, 100, 10);
//            [self.view addSubview:seg];
            
            x+=100;
        
        }
        i++;
        
    }
    
    
    
    
    
	// Do any additional setup after loading the view.
}
-(void)btnAction:(UIButton *)btn
{
    NSLog(@"%d",btn.tag);
}


-(NSString*)changeLine:(NSString *)str length:(float)length withFont:(float)font{
    
    NSMutableString * string = [NSMutableString stringWithString:str];
    NSString * str1 = [string substringWithRange:NSMakeRange(0, 1)];
    
    int i=1;
    
    CGSize size = [str1 sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
    
    while (size.width <length&i<string.length) {
        i++;
        str1 = [string substringWithRange:NSMakeRange(0, i)];
        
        size = [str1 sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(MAXFLOAT, 30)];
        //NSLog(@"%@===%d",str1,i);
    }
    
    return [string substringWithRange:NSMakeRange(0, i-1)];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
