# Q91121
MSD区块链基金交易平台

2019年11月25日19:07:29 今天把数据库设计好了，并且把基本ssm框架部署好了

2019年11月26日19:33:05 把后台的轮播图的新增、删除、修改实现了；新闻公告的增、删、改实现了；参数配置页面花了一上午做出来了；下午把参数修改，清空数据实现了，还做了一个 网站已运行时间的功能

2019年11月27日21:48:23 把框架不必要的代码全删了。数据全部做了缓存处理，前台的基础数据显示、登录、注册、退出登录功能的实现。

2019年11月28日09:29:15 前台修改登录、交易密码，寻回密码功能的实现，及申购SMD创建订单记录

2019年11月29日08:48:24 后台互助管理页面的实现、及前台赎回SMD的功能实现
 
2019年11月30日18:19:53 前台实现个人资料的修改及申购和赎回时增加需要完善个人资料才能申请，后台管理完善匹配管理功能，已经把数据传到后台，并且把选中的申购和赎回订单列表查询出来了，添加了一张匹配管理表，周一上班 用where循环写入匹配管理表即可，记得更新订单状态

2019年12月2日20:50:28 实现后台互助匹配系统的功能，前台完善匹配订单页面，及图片压缩上传

2019年12月3日21:16:59 研究出定时任务的实现，精确到秒，采用quartz实现

2019年12月4日21:16:59 静态奖金发放完成，添加了一张冻结明细表，用来记录 首尾款的释放日期等等

2019年12月5日20:18:30 动静态奖金定时释放完成，规定时间内打款完成，限制排单时间间隔完成