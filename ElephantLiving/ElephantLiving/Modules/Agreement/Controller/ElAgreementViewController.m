//
//  ElAgreementViewController.m
//  ElephantLiving
//
//  Created by dllo on 16/11/9.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElAgreementViewController.h"

@interface ElAgreementViewController ()

@end

@implementation ElAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    titleLabel.text = @"大象直播用户隐私政策";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor colorWithRed:1 green:0.5 blue:0 alpha:1];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    
    UIButton *returnButton = [UIButton buttonWithType:UIButtonTypeCustom];
    returnButton.backgroundColor = [UIColor clearColor];
    returnButton.frame = CGRectMake(SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.1, SCREEN_WIDTH * 0.09, SCREEN_WIDTH * 0.09);
    [returnButton setTitle:@"⇦" forState:UIControlStateNormal];
    returnButton.titleLabel.font = [UIFont systemFontOfSize:35];
    [returnButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    returnButton.centerY = titleLabel.centerY;
    [self.view addSubview:returnButton];

    [returnButton handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    textView.font = [UIFont systemFontOfSize:15];
    textView.text = @"    前言\n        大象直播提请您注意：您在使用大象直播的服务时，大象直播可能会中华人民共和国法律允许的框架下收集和使用您的信息。\n    大象直播希望通过本《隐私政策》向您说明在您使用大象直播的服务时，大象直播是如何收集、使用、储存和分享这些信息，以及大象直播为您提供的访问、更新、控制和保护这些信息的方式。本《隐私政策》与您所使用的大象直播服务息息相关，大象直播也希望您能够仔细阅读，并在需要时，按照本《隐私政策》的指引，作出您认为适当的选择。本《隐私政策》之中涉及的相关技术词汇，大象直播尽量以简明扼要的表述向您解释，并提供了进一步说明的链接，以便您的理解。 您使用或继续使用大象直播的服务，视为您同意大象直播按照本《隐私政策》收集、使用、储存和分享您的信息，包括您的个人隐私信息。\n    如您对本《隐私政策》或与本《隐私政策》相关的事宜有任何问题，请与我们联系。\n        大象直播收集的信息\n        大象直播提供服务时，可能会收集、储存和使用下列与您有关的信息。如果您不提供相关信息，可能无法注册成为分贝的用户、享受大象直播提供的某些服务，或者即便大象直播可以继续向您提供一些服务，也无法达到该服务拟达到的效果。\n        您提供的信息\n        您在注册大象直播的账户或使用大象直播的服务时，向大象直播提供的相关个人信息，例如电话号码、电子邮件等；    您通过大象直播的服务向其他方提供的共享信息，以及您使用大象直播的服务时所储存的信息.\n        其他方分享的您的信息\n        其他方使用大象直播的服务时所提供有关您的共享信息。\n        大象直播获取的您的信息\n        您使用大象直播服务时大象直播可能收集如下信息：\n    日志信息指您使用大象直播服务时，系统可能会通过cookies、web beacon或其他方式自动采集的技术信息，包括：\n    设备或软件信息，例如您的移动设备、网页浏览器或您用于接入大象直播的服务的其他程序所提供的配置信息、您的IP地址和您的移动设备所用的版本和设备识别码；\n    您在使用大象直播服务时搜索和浏览的信息，例如您使用的网页搜索词语、访问的社交媒体页面url地址，以及您在使用大象直播服务时浏览或要求提供的其他信息和内容详情；\n    有关您曾使用的移动应用（APP）和其他软件的信息，以及您曾经使用该等移动应用和软件的信息；\n    您通过大象直播的服务进行通讯的信息，例如曾通讯的账号，以及通讯时间、数据和时长；\n    您通过大象直播的服务分享的内容所包含的信息（元数据），例如拍摄或上传的共享照片或录像的日期、时间或地点等。\n    位置信息指您开启设备定位功能并使用大象直播基于位置提供的相关服务时，大象直播收集的有关您位置的信息，包括：    您通过具有定位功能的移动设备使用大象直播的服务时，大象直播通过GPS或WiFi等方式收集的您的地理位置信息；\n    您或其他用户提供的包含您所处地理位置的实时信息，例如您提供的账户信息中包含的您所在地区信息，您或其他人上传的显示您当前或曾经所处地理位置的共享信息，例如您或其他人共享的照片包含的地理标记信息；\n    您可以通过关闭定位功能随时停止大象直播对您的地理位置信息的收集。\n        大象直播如何使用您的信息\n        大象直播可能将在向您提供服务的过程之中所收集的信息用作下列用途：    向您提供服务；\n    在大象直播提供服务时，用于身份验证、客户服务、安全防范、诈骗监测、存档和备份用途，确保大象直播向您提供的产品和服务的安全性；\n    帮助大象直播设计新服务，改善大象直播现有服务；\n    使大象直播更加了解您如何接入和使用大象直播的服务，从而针对性地回应您的个性化需求，例如语言设定、位置设定、个性化的帮助服务和指示，或对您和其他使用大象直播服务的用户作出其他方面的回应；\n    向您提供与您更加相关的广告以替代普遍投放的广告；\n    评估大象直播服务中的广告和其他促销及推广活动的效果，并加以改善；\n    软件认证或管理软件升级；\n    让您参与有关大象直播产品和服务的调查。\n    为了让大象直播的用户有更好的体验、改善大象直播的服务或您同意的其他用途，在符合相关法律法规的前提下，大象直播可能将通过分贝的某一项服务所收集的个人信息，以汇集信息或者个性化的方式，用于大象直播的其他服务。例如，在您使用分贝的一项服务时所收集的您的个人信息，可能在另一服务中用于向您提供特定内容或向您展示与您相关的、而非普遍推送的信息。如大象直播在相关服务之中提供了相应选项，您也可以主动要求大象直播将您在该服务所提供和储存的个人信息用于大象直播的其他服务。\n    针对某些特定服务的特定隐私政策将更具体地说明大象直播在该等服务中如何使用您的信息。\n        如何访问和控制您的信息\n        大象直播将尽量采取适当的技术手段，保证您可以访问、更新和更正您的注册信息或使用大象直播的服务时提供的其他个人信息。在访问、更新、更正和删除您的个人信息时，大象直播可能会要求您进行身份验证，以保障您的账户安全。\n        大象直播如何分享您的信息\n        除以下情形外，未经您同意，大象直播、大象直播关联方或合作方不会与任何第三方分享您的个人信息：\n    大象直播以及大象直播的关联公司可能将您的个人信息与大象直播的关联公司、合作方及第三方服务供应商、承包商及代理、分享（他们可能并非位于您所在法域），用作下列用途：\n    向您提供大象直播的服务；\n    实现“大象直播如何使用您的信息”部分所述目的；    履行大象直播在本《隐私政策》中的义务和形式大象直播的权利；\n    理解、维护和改善大象直播的服务。\n    如大象直播或大象直播的关联公司与任何上述第三方分享您的个人信息，大象直播将努力确保该等第三方在使用您的个人信息时遵守本《隐私政策》及大象直播要求其遵守的其他适当的保密和安全措施。\n    随着大象直播业务的持续发展，大象直播以及大象直播的关联公司有可能进行合并、收购、资产转让或类似的交易，而您的个人信息有可能作为此类交易的一部分而被转移。大象直播将在您的个人信息转移前通知您。\n    大象直播或大象直播的关联公司还可能为以下需要保留、保存或披露您的个人信息：\n    遵守适用的法律法规；\n    遵守法院命令或其他法律程序的规定；\n    遵守相关政府机关的要求；\n    大象直播为遵守适用的法律法规、维护社会公共利益、或保护大象直播或大象直播的集团公司、大象直播的客户、其他用户或雇员的人身和财产安全或合法权益所合理必需的。        大象直播如何保留、储存和保护您的信息\n        大象直播仅在本《隐私政策》所述目的所必需期间和法律法规要求的时限内保留您的个人信息。大象直播使用各种安全技术和程序，以防信息的丢失、不当使用、未经授权阅览或披露。例如，在某些服务中，大象直播将利用加密技术（例如SSL）来保护您向大象直播提供的个人信息。但请您谅解，由于技术的限制以及风险防范的局限，即便大象直播已经尽量加强安全措施，也无法始终保证信息百分之百的安全。您需要了解，您接入大象直播的服务所用的系统和通讯网络，有可能因大象直播可控范围外的情况而发生问题。\n        有关共享信息的提示\n    大象直播的多项服务可让您不仅与您的社交网络、也与使用该服务的所有用户公开分享您的相关信息，例如，您在大象直播的服务中所上传或发布的信息（包括您公开的个人信息、您建立的名单）、您对其他人上传或发布的信息作出的回应，以及包括与这些信息有关的位置数据和日志信息。使用大象直播服务的其他用户也有可能分享与您有关的信息（包括位置数据和日志信息）。特别是大象直播的社交媒体服务，是专为使您可以与世界各地的用户共享信息而设计，从而使共享信息可实时、广泛的传递。只要您不删除共享信息，有关信息便一直留存在公众领域；即使您删除共享信息，有关信息仍可能由其他用户或不受大象直播控制的非关联第三方独立地缓存、复制或储存，或由其他用户或该等第三方在公众领域保存。\n    因此，请您认真考虑您通过大象直播的服务上传、发布和交流的信息内容。在一些情况下，您可通过大象直播某些服务的隐私设定来控制有权浏览您的共享信息的用户范围。如您要求从大象直播的服务中删除您的个人信息，请通过该等特别服务条款提供的方式操作。\n        有关敏感个人信息的提示\n    某些个人信息因其特殊性可能被认为是敏感个人信息，例如您的种族、宗教、个人健康和医疗信息等。相比其他个人信息，敏感个人信息受到更加严格的保护。\n    请注意，您在大象直播的服务中所提供、上传或发布的内容和信息（例如有关您社交活动的照片或信息），可能会泄露您的敏感个人信息。您需要谨慎地考虑，是否使用大象直播的服务披露您的敏感个人信息。 您同意您的敏感个人信息按本《隐私政策》所述的目的和方式来处理。\n    大象直播服务中的第三方服务\n    大象直播的服务可能包括或链接至第三方提供的社交媒体或其他服务（包括网站）。例如：\n    您可利用“分享”键将某些内容分享到大象直播的服务，或您可利用第三方连线服务登录大象直播的服务。这些功能可能会收集您的信息（包括您的日志信息），并可能在您的电脑装置cookies，从而正常运行上述功能；\n    大象直播通过广告或大象直播服务的其他方式向您提供链接，使您可以接入第三方的服务或网站。\n    该等第三方社交媒体或其他服务可能由相关的第三方或大象直播运营。您使用该等第三方的社交媒体服务或其他服务（包括您向该等第三方提供的任何个人信息），须受第三方自己的服务条款及隐私政策（而非《通用服务条款》或本《隐私政策》）约束，您需要仔细阅读其条款。本《隐私政策》仅适用于大象直播所收集的任何信息，并不适用于任何第三方提供的服务或第三方的信息使用规则，而大象直播对任何第三方使用由您提供的信息不承担任何责任。\n    年龄限制\n        大象直播鼓励父母或监护人指导未满十八岁的未成年人使用大象直播的服务。大象直播建议未成年人鼓励他们的父母或监护人阅读本《隐私政策》，并建议未成年人在提交的个人信息之前寻求父母或监护人的同意和指导。\n        本《隐私政策》的适用范围\n        除某些特定服务外，大象直播所有的服务均适用本《隐私政策》。这些特定服务将适用特定的隐私政策。该特定服务的隐私政策构成本《隐私政策》的一部分。如任何特定服务的隐私政策与本《隐私政策》有不一致之处，则适用特定服务的隐私政策。\n    请您注意，本《隐私政策》不适用于以下情况：\n    通过大象直播的服务而接入的第三方服务（包括任何第三方网站）收集的信息；\n    通过在大象直播服务中提供广告服务的第三方所收集的信息。    本《隐私政策》的修改\n    大象直播可能随时修改本《隐私政策》的条款，该等修改构成本《隐私政策》的一部分。如该等修改造成您在本《隐私政策》下权利的实质减少，大象直播将在修改生效前通过在主页上显著位置提示或向您发送电子邮件或以其他方式通知您，在该种情况下，若您继续使用大象直播的服务，即表示同意受经修订的本《隐私政策》的约束。\n\n\n\n\n\n";
    [self.view addSubview:textView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
