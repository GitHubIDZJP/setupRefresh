

#import "rootView.h"
#import "Model.h"
#define rectOfNavigationbar  self.navigationController.navigationBar.frame.size.height
#define rectOfStatusbar  [[UIApplication sharedApplication] statusBarFrame].size.height
#define DYTColor(r,g,b)[UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height
@interface rootView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *tab;
}
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation rootView
//懒加载
-(NSMutableArray*)dataArray
{
    if(_dataArray==nil)
    {
        _dataArray = [[NSMutableArray alloc]init];
        Model *modelData1=[[Model alloc]init];
        Model *modelData2=[[Model alloc]init];
        Model *modelData3=[[Model alloc]init];
        modelData1.name=@"曹魏";
        modelData1.desc=@"曹魏的疆域在曹操时即大幅发展，曹丕称帝建国后定型，约占有整个华北地区。大致上北至山西、河北及辽东，与南匈奴、鲜卑及高句丽相邻[57]  ；东至黄海。东南与孙吴对峙于长江淮河一带及汉江长江一带，以寿春、襄阳为重镇；西至甘肃，与河西鲜卑、羌及氐相邻。西南与蜀汉对峙于秦岭、河西一带，以长安为重镇。在立国后原有87郡及十二州，有：司隶、徐州、青州、豫州、冀州、并州、幽州、兖州、凉州、雍州、荆州、扬州。";
        modelData1.perArr=@[@"曹操(国君)",@"夏侯惇(大都督)",@"公孙渊(三朝元老)",@"乐进(都督)",@"曹仁(都督)"];
        modelData2.name=@"蜀汉";
        modelData2.desc=@"蜀汉为刘备所建，他直到赤壁之战后才在诸葛亮协助下，由荆州南部开始发展。其势力一度涵盖荆州、益州及汉中。立国前后与孙吴发生多次战争并损失荆州，于诸葛亮南定南中后获得云南一带疆域[15]  ，至此渐渐稳定。疆域范围：北方与曹魏对峙于秦岭，汉中为重镇；东与孙吴相邻于三峡，巴西为重镇；西南至岷江、南中，与羌、氐及南蛮相邻。蜀汉共有22郡、仅益州一州。于益州下设庲降都督，治味县，专辖益州南部。";
        modelData2.perArr=@[@"刘备(国君)",@"诸葛亮(大都督)",@"黄忠(三朝元老)",@"关羽(都督)",@"张飞(都督)"];
        modelData3.name=@"吴国";
        modelData3.desc=@"吴国（222年5月23日—280年5月1日），三国之一，是孙权在中国东南部建立的政权，国号为“吴”史学界称之为孙吴。";
        modelData3.perArr=@[@"孙权(国君)",@"周瑜(大都督)",@"黄盖(三朝元老)",@"吕蒙(都督)",@"陆逊(都督)"];
        [_dataArray addObject:modelData1];
        [_dataArray addObject:modelData2];
        [_dataArray addObject:modelData3];
    }
    return _dataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
   

   tab=[[UITableView alloc]initWithFrame:CGRectMake(0,0,WIDTH,HEIGHT-rectOfNavigationbar-rectOfStatusbar) style:UITableViewStyleGrouped];
    [self.view addSubview:tab];
    tab.delegate=self;
    tab.dataSource=self;
    
    [self setupRefresh];
    
   
}
//行
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //return _dataArray.count;
    return  self.dataArray.count;
    
}
//行*列
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    Model *modelNewDate=self.dataArray[section];
    return  modelNewDate.perArr.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        //获取Model
        
    }
    
    Model *model=self.dataArray[indexPath.section];
    
    cell.textLabel.text= [NSString  stringWithFormat:@"%@",model.perArr[indexPath.row]];
    //cell.detailTextLabel.text=@"df";
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Model *model=self.dataArray[section];
    return model.name;
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    Model *model=self.dataArray[section];
    return model.desc;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //操作
}
//赋值

- (void)setupRefresh {
    NSLog(@"setupRefresh -- 下拉刷新");
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor=[UIColor redColor];
    [refreshControl addTarget:self action:@selector(refreshClick:) forControlEvents:UIControlEventValueChanged];
    [tab addSubview:refreshControl];
//    [refreshControl beginRefreshing];
//    [self refreshClick:refreshControl];
}
// 下拉刷新触发，在此获取数据
- (void)refreshClick:(UIRefreshControl *)refreshControl
{
    NSLog(@"refreshClick: -- 刷新触发");
    // 此处添加刷新tableView数据的代码
   /**name;
   desc;
    perArr;*/
    Model *Newmodel=[[Model alloc]init];
    Newmodel.name=@"邹朝";
    Newmodel.desc=@"邹朝(2000-3000年12月31日)，天下霸主";
    Newmodel.perArr=@[@(1),@(2),@(3),@(4),@(5)];
    [self.dataArray addObject:Newmodel];
    
    

    [tab reloadData];// 刷新tableView即可
    
     [refreshControl endRefreshing];
    
}
@end
