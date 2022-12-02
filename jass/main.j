
#include "library/BlizzardAPI.j"
#include "library/YDWEBitwise.j"
#include "library/DzAPI.j"
#include "library/UI.j"
#include "library/ShowEffect.j"
#include "library/common_func.j"
#include "game_logic/LevelUp.j"
#include "library/buff.j"
#include "library/UniMissileSystem.j"
#include "library/encrypt.j"

#include "game_logic/Mall.j"
#include "game_logic/GameLogic.j"
#include "game_logic/GameDetail.j"
#include "game_logic/Equipment.j"
#include "game_logic/Instances.j"
#include "game_logic/Experiences.j"
#include "game_logic/Tasks.j"
#include "game_logic/Mongolia.j"

#include "game_logic/CleanItems.j"
#include "game_logic/Talent.j"
#include "game_logic/EnhanceDefense.j"
#include "game_logic/NpcHint.j"
#include "game_logic/ShowHealthPoint.j"
#include "game_logic/BlizzardEvent.j"
#include "game_logic/EverySecond.j"
#include "game_logic/PetSkill.j"
#include "game_logic/Passport.j"
#include "game_logic/JZUI.j"
#include "game_logic/Egg.j"


#include "systems/ElixirSystem.j"
#include "systems/Activity.j"


#include "test/najitest.j"
#include "test/KeyInput.j"
#include "TaoHuaDao.j"

// 包含门派库
#include "denomination/ShaoLin.j"
#include "denomination/GaiBang.j"
#include "denomination/XueDao.j"
#include "denomination/EMei.j"
#include "denomination/WuDang.j"
#include "denomination/HuaShan.j"
#include "denomination/XingXiu.j"
#include "denomination/GuMu.j"
#include "denomination/HengShan.j"
#include "denomination/HengShan2.j"
#include "denomination/LingJiuGong.j"
#include "denomination/MuRongJia.j"
#include "denomination/VIPMingJiao.j"
#include "denomination/ShenLong.j"
#include "denomination/QuanZhen.j"
#include "denomination/TangMen.j"
#include "denomination/TieZhang.j"
#include "denomination/TaiShan.j"
#include "denomination/WuDu.j"
#include "denomination/TaoHua.j" // 桃花岛武功
#include "denomination/YeLuo.j" // 野螺派武功
#include "denomination/XueShan.j" // 雪山派武功
#include "denomination/RuYang.j" // 汝阳王府武功
#include "denomination/SongShan.j" // 嵩山武功
#include "denomination/RiYue.j" // 日月神教武功

#include "denomination/JiangHuWuGong.j"
#include "denomination/JueShiWuGong.j"
#include "denomination/JiangHuNeiGong.j"


#include "TiaoZhan.j"
#include "ZiZhiWuGong.j"
#include "ZhenFa.j"
#include "QiWu.j"

#include "zhangmen_skill/zhangmen_skill.j"
#include "smelt_weapon/smelt_weapon.j"
#include "CreateDestructables.j"
#include "CreateUnitsAndInitEnvironments.j"

#include "systems/UnitAttack.j"
#include "systems/UseAbility.j"
#include "systems/UnitDamage.j"
#include "systems/UnitDeath.j"
#include "systems/ItemEvent.j"


#include "InitialSave.j"



globals
	unit array vipbanlv
	item yd_NullTempItem
	unit w = null
	unit z = null
	unit A = null
	unitpool B = null
	item C = null
	itempool D = null

	
	unit udg_sixiangdanwei = null
	unit udg_xuezhandanwei = null
	unit udg_fanweidanwei = null
	unit udg_fomiedanwei = null
	unit udg_yechadanwei = null
	unit udg_miejuedanwei = null
	integer array wugongshu
	integer array udg_zhemei
	
	integer array chief // 掌门标识，使用2进制的方式标注获得了哪个门派的掌门
	integer array title0 // 称号标识，使用2进制的方式标注获得了哪个称号 1-30
	integer array title1 // 称号标识，使用2进制的方式标注获得了哪个称号 31-60
	integer array deputy // 副职标识
	integer array master // 大师标识
	integer array qimen_status // 奇门术数标识
	
	integer array ateDenom // 是否吞了专属
	integer array ateTianShu // 是否吞了天书
	boolean array qiankunCd // 乾坤是否处于CD中

	// 多通速17门派数组，每位玩家的通关门派
	string array manySuccess
	// 单通速17门派数组，每位玩家的通关门派
	string array singleSuccess
	string initMpSaveStr = "0000000000000000000000000"
	string fullMpSaveStr = "1111111111111111111111111"
	
	// 是否第一次难度为最高
	boolean topDegreeFlag = false
	// 多通难7奖励额外双倍积分，和商城的叠加
	integer array extraDoubleJf 
	// 多通奖励移速100
	integer array extraSpeed
	
	integer array jfQiWu // 玩家已经兑换奇武次数
	integer array jfQiWuLimit // 玩家兑换奇武限定次数，默认3次，单通8门派奖励1次
	
	// 战斗力数组，每位玩家的战斗力
	integer array udg_zdl
	// 积分数组
	integer array udg_jf
	// 每局可用积分80分
	integer jf_max = 80
	// 每局已用积分
	integer array jf_useMax
	// 通关次数数组
	integer array udg_success
	// 当前局获取到的战斗力
	integer get_zdl = 0
	// 存档是否已保存
	boolean array saveFlag
	// 在线玩家数量
	integer udg_wanjiashu = 0
	// 是否是测试版
	boolean testVersion = false
	// 奖励的武功伤害
	real array bonus_wugong
	// 奖励的爆伤
	real array bonus_baoshang
	// 最高伤害，打测试桩
	real array max_damage
	// 卖技能书的少林高僧
	unit array udg_sellSkillBook
	
	integer udg_tiebushancengshu = 0
	integer udg_nandu = 0
	
	boolean udg_shifoufomie = false
	boolean udg_teshushijian = false
	boolean udg_yanglao = false
	// 返璞归真模式
	boolean udg_fpgz = false
	boolean udg_yunyangxianshen = false
	boolean udg_sutong = false
	boolean array showDamage
	boolean array showEffect
	dialog udg_index = null
	button udg_index0 = null
	button udg_index1 = null
	button udg_index2 = null
	button udg_index3 = null
	button udg_index4 = null
	dialog udg_nan = null
	button udg_nan0 = null
	button udg_nan1 = null
	button udg_nan2 = null
	button udg_nan3 = null
	button udg_nan4 = null
	button udg_nan5 = null
	button udg_nan7 = null
	button udg_nan8 = null
	// 挑战模式dialog
	dialog udg_tiaoZhan = null
	button udg_tiaoZhan0 = null // 速通模式按钮
	button udg_tiaoZhan1 = null // 无技能商店按钮
	button udg_tiaoZhan2 = null // 无尽BOSS战按钮
	button udg_tiaoZhan3 = null // 返璞归真模式按钮
	button udg_tiaoZhan4 = null // 无书速通模式按钮

	integer udg_gudongA = 0
	integer udg_gudongB = 0
	integer udg_gudongC = 0
	integer udg_gudongD = 0
	integer array udg_xinggeA
	integer array udg_xinggeB
	integer array udg_vip
	integer array udg_changevip
	integer array udg_elevenvip
	// 是否是测试人员
	boolean array udg_isTest
	// 是否开启测试码开关，全局存档，后台可以控制
	string admin = "0" // 默认开启
	// 通知内容，后台控制开局对用户输出内容
	string info = ""
	// 积分倍数，全局存档
	string jfBeishu = "1"
	integer array udg_jianghu
	integer array udg_juexue
	integer array udg_juenei
	integer array udg_canzhang
	integer array udg_qiwu
	integer array udg_dan
	integer array udg_weapon
	integer array aidacishu
	integer array udg_wuqishu
	integer array udg_yifushu
	trigger array K
	integer array L
	integer M = 0
	integer O = 16
	integer array P
	integer array Q
	integer array S
	integer array T
	integer U = 1752196449
	integer array V
	boolean W = true
	integer array X
	integer array Y
	integer array udg_shuxing
	force Z
	item d4
	group e4
	group udg_shanghaidanweizu = null
	trigger f4 = null
	trigger array g4
	integer h4 = 0
	item i4 = null
	trigger array k4
	integer m4 = 0
	region nn4
	constant timer o4 = CreateTimer()
	integer p4
	integer q4
	integer r4
	integer s4
	integer t4
	integer array u4
	integer array v4
	integer array w4
	trigger array x4
	integer array qiuhun
	integer array xidujuexue
	integer array zhaoyangguo
	integer array linganran
	integer array touxiao
	integer array bihai
	trigger y4
	trigger z4
	trigger A4
	trigger a4
	trigger B4
	trigger b4
	timer C4
	integer c4
	integer D4 = 0
	integer array juexuelingwu
	real array udg_baojishanghai
	real array udg_baojilv
	real array shanghaihuifu
	real array shaguaihufui
	real array shengminghuifu
	real array falihuifu
	real array udg_lilianxishu
	location udg_loc1 = null
	unit array K4
	unit array L4
	boolean array udg_hashero
	boolean array udg_baoji
	boolean array udg_yiwang
	unit array udg_hero
	// 江湖等级
	integer array jianghuLevel
	integer O4 = 0
	unit array P4
	location Q4 = null
	dialog array R4
	button array S4
	button array T4
	button array U4
	button array V4
	button array W4
	button array X4
	integer array Y4
	integer array wuxing
	integer array jingmai
	integer array gengu
	integer array fuyuan
	integer array danpo
	integer array yishu
	integer array special_attack
	group i7 = null
	integer array udg_runamen
	integer k7 = 0
	location array m7
	integer nn7 = 0
	integer o7 = 0
	integer udg_counter1 = 0
	integer array q7
	unit array r7
	integer s7 = 0
	integer udg_boshu = 0
	integer array u7
	location array v7
	group w7 = null
	integer x7 = 0
	integer array y7
	timerdialog array z7
	timer array A7
	boolean ShiFouShuaGuai = false
	integer B7 = 0
	unit array b7
	unit array C7
	integer c7 = 0
	real array D7
	effect array E7
	integer array F7
	integer array G7
	integer H7 = 0
	integer array I7
	button array l7
	button array J7
	button array J78
	button array J79
	button array J710
	button array J711
	dialog array K7
	dialog udg_menpaineigong
	integer array L7
	integer MM7 = 0
	integer N7 = 0
	integer array O7
	integer array P7
	integer array wolfSkinCount // 狼皮数量统计
	integer array wolfSkinFlag // 狼皮任务标记
	timer array udg_revivetimer
	timerdialog array R7
	integer array S7
	real T7 = 0
	real U7 = 0
	real array udg_MaxDamage
	string array udg_menpainame
	integer array denomFirst
	integer array denomSecond
	integer array denomThird
	integer array d8
	integer array e8
	integer array shengwang
	integer array g8
	integer array h8
	integer array i8
	integer array j8
	unit array k8
	unit array udg_boss
	boolean array m8
	boolean array o8
	unit array p8
	integer array q8
	unit array r8
	player s8 = null
	boolean t8 = false
	integer array yongdanshu
	dialog array v8
	button array w8
	button array x8
	button array y8
	button array z8
	button array A8
	button array a8
	button array B8
	boolean array b8
	boolean array C8
	boolean array c8
	dialog array D8
	integer E8 = 0
	boolean array F8
	boolean array XNKL
	boolean array daxia
	boolean array G8
	boolean array H8
	boolean array I8
	boolean array l8
	integer array J8
	integer array K8
	integer array xiuxing
	integer array MM8
	integer array N8
	integer array O8
	integer array denomFifth
	integer array denomFourth
	integer array R8
	integer array S8
	integer array udg_blgg
	integer array udg_blwx
	integer array udg_bljm
	integer array udg_blfy
	integer array udg_bldp
	integer array udg_blys
	integer array udg_jdds
	integer array udg_ldds
	integer array udg_xbds
	integer array udg_bqds
	integer array udg_dzds
	integer array udg_jwjs
	boolean array Z8
	boolean array d9
	boolean array e9
	timer array f9
	timerdialog array g9
	boolean array h9
	integer array i9
	group xianglongGroup = null
	group k9 = null
	real m9 = 0
	real n9 = 0
	location array o9
	integer p9 = 0
	unit array q9
	group r9 = null
	group s9 = null
	location array t9
	integer u9 = 0
	boolean array v9
	boolean array w9
	boolean array x9
	boolean array y9
	integer array z9
	integer array A9
	item array a9
	location array B9
	unit array b9
	unit C9 = null
	location c9 = null
	unit D9 = null
	lightning array E9
	integer F9 = 0
	integer array G9
	integer array H9
	integer array I9
	integer array l9
	unit array J9
	unit array qiankun2hao
	unit array qiankun3hao
	real array udg_shanghaijiacheng
	real array udg_shanghaixishou
	real array max_damage_absorb
	integer array MM9
	real array udg_jueneishxs
	real array udg_jueneishjc
	integer array udg_jueneiminjie
	integer array udg_jueneijxlw
	real array udg_jueneibaojilv
	integer S9 = 0
	boolean array T9
	integer array LLguaiA
	integer array LLguaiE
	integer array LLguaiB
	integer array LLguaiC
	integer array LLguaiD
	integer array LLguaiF
	integer array LLguaiG
	timer array Z9
	timerdialog array dd
	boolean array ed
	timer array fd
	timerdialog array gd
	boolean hd = false
	integer array jd
	integer array kd
	integer array gudong
	integer array nd
	integer array od
	integer array pd
	integer array qd
	integer array rd
	integer array ud
	effect array vd
	integer array wugongxiuwei
	integer array xd
	integer array yd
	integer zd = 0
	boolean array Ad
	integer ad = 0
	boolean array Bd
	unit array bd
	integer array Cd
	boolean array cd
	integer array Dd
	integer array Ed
	group array Fd
	real array Gd
	timer array Hd
	integer array Id
	integer array ld
	integer array Jd
	integer array JYd //九阳残卷
	integer array Kd
	integer array Ld
	integer array Md
	integer array Nd
	integer array Od
	integer array Pd
	integer array Qd
	boolean array Rd
	integer array Sd
	integer array Td
	integer array Ud
	integer array Vd
	integer array Wd
	integer array jiuazi
	integer Xd = 0
	integer Yd = 0
	integer Zd = 0
	boolean de = false
	texttag array ee
	integer array shoujiajf
	boolean array ge
	boolean array he
	integer ie = 0
	dialog array je
	button array ke
	button array me
	button array ne
	button array oe
	button array pe
	button array qe
	button array re
	button array rre
	button array re9
	button array re10
	button array re11
	button array se
	integer array te
	integer ue = 5
	integer array ve
	integer array xe
	integer array ye
	integer array ze
	integer array Ae
	integer ae = 0
	integer array YaoCao
	integer array ShiPin
	integer array ZhuangBei
	integer array mapLevelReward
	integer array ce
	boolean array De
	boolean array Ee
	group Fe = null
	rect udg_jail = null
	rect udg_yizhan = null
	rect udg_xuanmenpai = null
	rect udg_tiaozhanqu = null
	rect Ge = null
	rect He = null
	rect Ie = null
	rect le = null
	rect Je = null
	rect Ke = null
	rect Le = null
	rect Me = null
	rect Ne = null
	rect Oe = null
	rect Pe = null
	rect botong = null
	rect Qe = null
	rect Re = null
	rect Se = null
	rect Te = null
	rect Ue = null
	rect Ve = null
	rect We = null
	rect Xe = null
	rect Ye = null
	rect Ze = null
	rect df = null
	rect lh_r = null
	rect ef = null
	rect ff = null
	rect gf = null
	rect hf = null
	rect jf = null
	rect kf = null
	rect mf = null
	rect nf = null
	rect of = null
	rect pf = null
	rect qf = null
	rect rf = null
	rect sf = null
	rect tf = null
	rect uf = null
	rect vf = null
	rect wf = null
	rect xf = null
	rect yf = null
	rect zf = null
	rect Af = null
	rect af = null
	rect Bf = null
	rect bf = null
	rect Cf = null
	rect cf = null
	rect Df = null
	rect Ef = null
	rect Ff = null
	rect Gf = null
	rect Hf = null
	rect If = null
	rect lf = null
	rect Jf = null
	rect Kf = null
	rect Lf = null
	rect Mf = null
	rect Nf = null
	rect Of = null
	rect Pf = null
	rect Qf = null
	rect Rf = null
	rect Sf = null
	rect Tf = null
	rect Uf = null
	rect Vf = null
	rect Wf = null
	rect Xf = null
	rect Yf = null
	rect Zf = null
	rect dg = null
	rect eg = null
	rect fg = null
	rect gg = null
	rect hg = null
	rect ig = null
	rect jg = null
	rect kg = null
	rect mg = null
	rect ng = null
	rect og = null
	rect pg = null
	rect qg = null
	rect rg = null
	rect sg = null
	rect tg = null
	rect ug = null
	rect vg = null
	rect wg = null
	rect xg = null
	rect yg = null
	rect zg = null
	rect Ag = null
	rect ag = null
	rect Bg = null
	rect bg = null
	rect Cg = null
	rect cg = null
	rect Dg = null
	rect Eg = null
	rect Fg = null
	rect Gg = null
	rect Hg = null
	rect Ig = null
	rect lg = null
	rect Jg = null
	rect Kg = null
	rect Lg = null
	rect Mg = null
	rect Ng = null
	rect Og = null
	rect Pg = null
	rect Qg = null
	rect Rg = null
	rect Sg = null
	rect Ug = null
	rect Vg = null
	rect Wg = null
	rect Xg = null
	rect Yg = null
	rect Zg = null
	rect dh = null
	rect eh = null
	rect fh = null
	rect gh = null
	rect hh = null
	rect udg_liuqiu = null
	rect jh = null
	rect kh = null
	rect mh = null
	rect nh = null
	rect oh = null
	rect ph = null
	rect qh = null
	rect rh = null
	rect sh = null
	rect th = null
	rect uh = null
	rect vh = null
	sound wh = null
	string xh = "Sound\\Music\\mp3Music\\ArthasTheme.mp3"
	string yh = "war3mapImported\\wulindahui3.mp3"
	string zh = "Sound\\Music\\mp3Music\\War2IntroMusic.mp3"
	sound ah = null
	sound Bh = null
	sound bh = null
	sound Ch = null
	sound Dh = null
	sound Eh = null
	sound Fh = null
	sound Gh = null
	sound Hh = null
	sound Ih = null
	trigger lh = null
	trigger Jh = null
	trigger Kh = null
	trigger Mh = null
	trigger Nh = null
	trigger Oh = null
	trigger Ph = null
	trigger Qh = null
	trigger Rh = null
	trigger Th = null
	trigger Uh = null
	trigger Vh = null
	trigger Wh = null
	trigger Xh = null
	trigger Yh = null
	trigger Zh = null
	trigger di = null
	trigger ei = null
	trigger fi = null
	trigger gi = null
	trigger hi = null
	trigger ii = null
	trigger ji = null
	trigger ki = null
	trigger mi = null
	trigger ni = null
	trigger oi = null
	trigger pi = null
	trigger ri = null
	trigger si = null
	trigger ti = null
	trigger ui = null
	trigger vi = null
	trigger wi = null
	trigger xi = null
	trigger yi = null
	trigger zi = null
	trigger Ai = null
	trigger ai = null
	trigger Bi = null
	trigger bi = null
	trigger Ci = null
	trigger ci = null
	trigger Di = null
	trigger Ei = null
	trigger Fi = null
	trigger Gi = null
	trigger Hi = null
	trigger Ii = null
	trigger li = null
	trigger Ji = null
	trigger Ki = null
	trigger Li = null
	trigger Mi = null
	trigger Ni = null
	trigger Oi = null
	trigger Pi = null
	trigger Qi = null
	trigger Ri = null
	trigger Si = null
	trigger Ti = null
	trigger Ui = null
	trigger Vi = null
	trigger Wi = null
	trigger Xi = null
	trigger Yi = null
	trigger Zi = null
	trigger dj = null
	trigger ej = null
	trigger fj = null
	trigger gj = null
	trigger hj = null
	trigger ij = null
	trigger jj = null
	trigger kj = null
	trigger mj = null
	trigger nj = null
	trigger oj = null
	trigger pj = null
	trigger qj = null
	trigger rj = null
	trigger sj = null
	trigger tj = null
	trigger uj = null
	trigger vj = null
	trigger wj = null
	trigger xj = null
	trigger yj = null
	trigger zj = null
	trigger Aj = null
	trigger aj = null
	trigger Bj = null
	trigger bj = null
	trigger Cj = null
	trigger cj = null
	trigger Dj = null
	trigger Ej = null
	trigger Fj = null
	trigger Gj = null
	trigger Hj = null
	trigger Ij = null
	trigger lj = null
	trigger Jj = null
	trigger Kj = null
	trigger Lj = null
	trigger Mj = null
	trigger Nj = null
	trigger Oj = null
	trigger Pj = null
	trigger Qj = null
	trigger Rj = null
	trigger Sj = null
	trigger Tj = null
	trigger Uj = null
	trigger Vj = null
	trigger Wj = null
	trigger Xj = null
	trigger Yj = null
	trigger Zj = null
	trigger dk = null
	trigger ek = null
	trigger fk = null
	trigger gk = null
	trigger hk = null
	trigger ik = null
	trigger jk = null
	trigger kk = null
	trigger mk = null
	trigger nk = null
	trigger ok = null
	trigger pk = null
	trigger qk = null
	trigger rk = null
	trigger sk = null
	trigger tk = null
	trigger uk = null
	trigger vk = null
	trigger wk = null
	trigger xk = null
	trigger yk = null
	trigger zk = null
	trigger Ak = null
	trigger ak = null
	trigger Bk = null
	trigger bk = null
	trigger Ck = null
	trigger ck = null
	trigger Dk = null
	trigger Ek = null
	trigger Fk = null
	trigger Gk = null
	trigger Hk = null
	trigger Ik = null
	trigger lk = null
	trigger Jk = null
	trigger Kk = null
	trigger Lk = null
	trigger Mk = null
	trigger Nk = null
	trigger Ok = null
	trigger Pk = null
	trigger Qk = null
	trigger Rk = null
	trigger Sk = null
	trigger Tk = null
	trigger Uk = null
	trigger Vk = null
	trigger Wk = null
	trigger Xk = null
	trigger Yk = null
	trigger Zk = null
	trigger dm = null
	trigger em = null
	trigger fm = null
	trigger gm = null
	trigger hm = null
	trigger im = null
	trigger jm = null
	trigger km = null
	trigger mm = null
	trigger nm = null
	trigger om = null
	trigger pm = null
	trigger qm = null
	trigger rm = null
	trigger sm = null
	trigger um = null
	trigger vm = null
	trigger wm = null
	trigger xm = null
	trigger ym = null
	trigger zm = null
	trigger Am = null
	trigger am = null
	trigger Bm = null
	trigger bm = null
	trigger Cm = null
	trigger cm = null
	trigger Dm = null
	trigger Em = null
	trigger Fm = null
	trigger Gm = null
	trigger Hm = null
	trigger Im = null
	trigger lm = null
	trigger Jm = null
	trigger Km = null
	trigger Lm = null
	trigger Mm = null
	trigger Nm = null
	trigger Om = null
	trigger Pm = null
	trigger Qm = null
	trigger Rm = null
	trigger Sm = null
	trigger Tm = null
	trigger Um = null
	trigger Vm = null
	trigger Wm = null
	trigger Xm = null
	trigger Ym = null
	trigger Zm = null
	trigger dn = null
	trigger en = null
	trigger fn = null
	trigger gn = null
	trigger hn = null
	trigger in = null
	trigger jn = null
	trigger kn = null
	trigger mn = null
	trigger nn = null
	trigger on = null
	trigger pn = null
	trigger qn = null
	trigger sn = null
	trigger tn = null
	trigger un = null
	trigger vn = null
	trigger wn = null
	trigger xn = null
	trigger yn = null
	trigger zn = null
	trigger An = null
	trigger an = null
	trigger Bn = null
	trigger bn = null
	trigger Cn = null
	trigger cn = null
	trigger Dn = null
	trigger En = null
	trigger Fn = null
	trigger Gn = null
	trigger Hn = null
	trigger In = null
	trigger Jn = null
	trigger Kn = null
	trigger Ln = null
	trigger Mn = null
	trigger Nn = null
	trigger On = null
	trigger Pn = null
	trigger Qn = null
	trigger Rn = null
	trigger Sn = null
	trigger Tn = null
	trigger Un = null
	trigger Vn = null
	trigger Wn = null
	trigger Xn = null
	trigger Yn = null
	trigger Zn = null
	trigger do = null
	trigger eo = null
	trigger fo = null
	trigger go = null
	trigger ho = null
	trigger io = null
	trigger jo = null
	trigger ko = null
	trigger mo = null
	trigger no = null
	trigger oo = null
	trigger po = null
	trigger qo = null
	trigger ro = null
	trigger so = null
	trigger to = null
	trigger uo = null
	trigger vo = null
	trigger wo = null
	trigger xo = null
	trigger yo = null
	trigger zo = null
	trigger Ao = null
	trigger ao = null
	trigger Bo = null
	trigger bo = null
	trigger Co = null
	trigger co = null
	trigger Do = null
	trigger Eo = null
	trigger Fo = null
	trigger Go = null
	trigger Ho = null
	trigger Io = null
	trigger lo = null
	trigger Jo = null
	trigger Ko = null
	trigger Lo = null
	trigger Mo = null
	trigger No = null
	trigger Oo = null
	trigger Po = null
	trigger Qo = null
	trigger Ro = null
	trigger So = null
	trigger To = null
	trigger Uo = null
	trigger Vo = null
	trigger Wo = null
	trigger Yo = null
	trigger Zo = null
	trigger dp = null
	trigger ep = null
	trigger fp = null
	trigger gp = null
	trigger hp = null
	trigger jp = null
	trigger kp = null
	trigger mp = null
	trigger np = null
	trigger op = null
	trigger pp = null
	trigger qp = null
	trigger sp = null
	trigger tp = null
	trigger vp = null
	trigger wp = null
	trigger xp = null
	trigger yp = null
	trigger zp = null
	trigger Ap = null
	trigger ap = null
	trigger Bp = null
	trigger bp = null
	trigger Cp = null
	trigger cp = null
	trigger Dp = null
	trigger Ep = null
	trigger Fp = null
	trigger Gp = null
	trigger Hp = null
	trigger Ip = null
	trigger lp = null
	trigger Jp = null
	trigger Kp = null
	trigger Lp = null
	trigger Mp = null
	trigger Np = null
	trigger Op = null
	trigger Pp = null
	trigger Qp = null
	trigger Rp = null
	trigger Sp = null
	trigger Tp = null
	trigger Up = null
	trigger Vp = null
	trigger Wp = null
	trigger Xp = null
	trigger Yp = null
	trigger Zp = null
	trigger dq = null
	trigger eq = null
	trigger fq = null
	trigger gq = null
	trigger hq = null
	trigger iq = null
	trigger jq = null
	trigger kq = null
	trigger mq = null
	trigger nq = null
	trigger oq = null
	trigger pq = null
	trigger qq = null
	trigger rq = null
	trigger sq = null
	trigger tq = null
	trigger uq = null
	trigger vq = null
	trigger xq = null
	trigger Cq = null
	trigger cq = null
	trigger Dq = null
	trigger Eq = null
	trigger Fq = null
	trigger Gq = null
	trigger Hq = null
	trigger Iq = null
	trigger lq = null
	trigger Jq = null
	trigger Kq = null
	trigger Lq = null
	trigger Mq = null
	trigger Nq = null
	trigger Oq = null
	trigger Pq = null
	trigger Qq = null
	trigger Rq = null
	trigger Sq = null
	trigger Tq = null
	trigger Uq = null
	trigger Wq = null
	trigger Xq = null
	trigger Yq = null
	trigger Zq = null
	trigger dr = null
	trigger er = null
	trigger fr = null
	trigger gr = null
	trigger hr = null
	trigger ir = null
	trigger jr = null
	trigger kr = null
	trigger mr = null
	trigger nr = null
	trigger pr = null
	trigger qr = null
	trigger rr = null
	trigger sr = null
	trigger tr = null
	trigger ur = null
	trigger vr = null
	trigger wr = null
	trigger xr = null
	trigger yr = null
	trigger zr = null
	trigger Ar = null
	trigger ar = null
	trigger Br = null
	trigger br = null
	trigger Cr = null
	trigger cr = null
	trigger Dr = null
	trigger Er = null
	trigger Fr = null
	trigger Gr = null
	trigger Hr = null
	trigger Ir = null
	trigger lr = null
	trigger Jr = null
	trigger Kr = null
	trigger Lr = null
	trigger Mr = null
	trigger Nr = null
	trigger Pr = null
	trigger Qr = null
	trigger Rr = null
	trigger Sr = null
	trigger Tr = null
	trigger Ur = null
	trigger Vr = null
	trigger Wr = null
	trigger Xr = null
	trigger Yr = null
	trigger Zr = null
	trigger ds = null
	trigger es = null
	trigger fs = null
	trigger gs = null
	trigger hs = null
	trigger is = null
	trigger js = null
	trigger ks = null
	trigger ms = null
	trigger ns = null
	trigger os = null
	trigger ps = null
	trigger qs = null
	trigger rs = null
	trigger ss = null
	trigger ts = null
	trigger vs = null
	trigger cs = null
	trigger Ds = null
	trigger Es = null
	trigger Fs = null
	trigger Gs = null
	trigger Hs = null
	trigger Is = null
	trigger ls = null
	trigger Js = null
	trigger Ks = null
	unit Ls = null
	unit udg_ZhengPaiWL = null
	unit GU_DONG_SHANG_REN = null
	unit BAO_SHI_SHANG_REN = null
	unit PING_YI_ZHI = null
	unit SHI_PO_TIAN = null
	unit Ns = null
	unit Os = null
	unit Ps = null
	unit Qs = null
	unit Rs = null
	unit tianXiaMenPai2 = null
	unit tianXiaMenPai3 = null
	unit LanXin = null
	unit XuanJin = null
	unit kongYao = null
	unit qiXiao = null
	unit Ss = null
	unit Ts = null
	unit Us = null
	unit Vs = null
	unit Ws = null
	unit Xs = null
	unit Ys = null
	unit Zs = null
	unit ft = null
	unit gt = null
	unit ht = null
	unit jt = null
	unit kt = null
	unit nt = null
	unit ot = null
	unit ut = null
	unit vt = null
	unit xt = null
	unit yt = null
	unit zt = null
	unit At = null
	unit Bt = null
	unit Ct = null
	unit ct = null
	unit Dt = null
	unit Et = null
	unit Ft = null
	destructable Gt = null
	trigger Ht = null
	trigger It = null
	trigger Jt = null
	integer Kt = 0
	integer Lt = 0
	integer array Mt
	integer array Nt
	integer Ot = 0
	unit array Pt
	unit array Qt
	real array Rt
	real array St
	real array Tt
	real array Ut
	real array Vt
	real array Wt
	real array Xt
	real array Yt
	real array Zt
	real fu = .0
	real gu = .0
	boolexpr ju = null
endglobals

//刚进入地图
function Zw takes nothing returns nothing
	call FogEnableOff()
	call FogMaskEnableOff()
	call SetCreepCampFilterState(false)
	call jw(false)
	call SetPlayerAllianceStateBJ(Player(12), Player(6), 3)
	call SetPlayerHandicapXP(Player(0), .43)
	call SetPlayerHandicapXP(Player(1), .43)
	call SetPlayerHandicapXP(Player(2), .43)
	call SetPlayerHandicapXP(Player(3), .43)
	call SetPlayerHandicapXP(Player(4), .43)
	call SetCameraField(CAMERA_FIELD_TARGET_DISTANCE, 2200., .0)
	call SaveInteger(YDHT, GetHandleId(Player(0)), 0xA816E128, 2200)
	call PlayMusicBJ(xh)
	set K4[1] = Ls
	set K4[2] = Qs
	set K4[3] = Os
	set K4[4] = Ns
	set K4[5] = Ps
	set K4[6] = LanXin
	set K4[7] = XuanJin
	set K4[8] = kongYao
	set K4[9] = qiXiao
	call GroupAddUnit(i7, Ls)
	call GroupAddUnit(i7, Ns)
	call GroupAddUnit(i7, Qs)
	call GroupAddUnit(i7, Os)
	call GroupAddUnit(i7, Ps)
	call GroupAddUnit(i7, LanXin)
	call GroupAddUnit(i7, XuanJin)
	call GroupAddUnit(i7, kongYao)
	call GroupAddUnit(i7, qiXiao)
	set y7[1] = 1969711215
	set y7[2] = 1970498413
	set y7[3] = 1852798821
	set y7[4] = 1851879023
	set y7[5] = 1852008562
	set y7[6] = 1852273524
	set y7[7] = 1969381742
	set y7[8] = 1852466993
	set y7[9] = 1869898354
	set y7[10] = 1853320292
	set y7[11] = 1852208244
	set y7[12] = 1701077869
	set y7[13] = 1751410807
	set y7[14] = 1852076648
	set y7[15] = 1970107511
	set y7[16] = 1852990571
	set y7[17] = 1852207714
	set y7[18] = 1869898347
	set y7[19] = 1853517677
	set y7[20] = 1869311844
	set y7[21] = 1852076404
	set y7[22] = 1852076662
	set y7[23] = 1852204908
	set y7[24] = 1701013613
	set y7[25] = 1853125236
	set y7[26] = 1852601452
	set y7[27] = 1702064246
	set y7[28] = 1852403302
	set y7[29] = 'nbdk'
	set y7[30] = 'nhyd'
	set u7[1] = 'ncer'
	set u7[2] = 'nhea'
	set u7[3] = 'nlkl'
	set u7[4] = 'nele'
	set u7[5] = 'nenp'
	set u7[6] = 'nbda'
	set u7[7] = 'n002'
	set u7[8] = 'nbds'
	//call SetHeroLevel(gg_unit_N008_0054,99,true)
	call SetUnitLifePercentBJ(gg_unit_N007_0055, 5)
	call SetUnitLifePercentBJ(gg_unit_N012_0095, 5)
	//call UnitAddAbility(gg_unit_N00F_0112,'A02Z')
	//call IssueTargetOrderById(gg_unit_N00F_0112, 852063, gg_unit_N007_0055)
	call AddSpecialEffectTargetUnitBJEx("overhead", Ts, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", Ft, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", Ss, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", vt, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", ot, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", nt, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", Et, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", ct, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", zt, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", Ct, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", ut, "Objects\\RandomObject\\RandomObject.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", xt, "Objects\\RandomObject\\RandomObject.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", yt, "Objects\\RandomObject\\RandomObject.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", Dt, "Objects\\RandomObject\\RandomObject.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", At, "Objects\\RandomObject\\RandomObject.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", Bt, "Objects\\RandomObject\\RandomObject.mdl")
	call AddSpecialEffectTargetUnitBJEx("overhead", gg_unit_N007_0055, "Abilities\\Spells\\Other\\TalkToMe\\TalkToMe.mdl")
	call CreateTextTagUnitBJ("双击选人再选门派", Rs, .0, 15., 100., 100., .0, 50.)
	// call CreateTextTagUnitBJ("新手教官",SuiFeng,.0,15.,100.,100.,.0,50.)
	// call CreateTextTagLocBJ("新手教官",Location(420,-597),100.0,15.,100.,100.,.0,50.)
	// call CreateTextTagLocBJ("地图等级福利",Location(-1500,-113),100.0,15.,100.,100.,.0,50.)
	// call CreateTextTagLocBJ("积分商店",Location(-1500,-1344),120.0,15.,100.,100.,.0,50.)
	call CreateTextTagLocBJ("决战江湖名人榜", GetRectCenter(uh), 100., $A, 100, 100, .0, 50.)
	set v7[1] = GetRectCenter(Ie)
	set v7[2] = GetRectCenter(le)
	set v7[3] = GetRectCenter(Je)
	set v7[4] = GetRectCenter(Ke)
	set v7[5] = GetRectCenter(Le)
	set v7[6] = GetRectCenter(Me)
	set v7[7] = GetRectCenter(Ne)
	set v7[8] = GetRectCenter(Oe)
	set v7[9] = GetRectCenter(Ge)
	set v7[$A] = GetRectCenter(Re)
	set v7[$B] = GetRectCenter(ff)
	set C7[1] = ft
	set C7[2] = gt
	set C7[3] = ht
	set C7[4] = jt
	set C7[5] = kt
	set b7[1] = Us
	set b7[2] = Zs
	set b7[3] = Ys
	set b7[4] = Xs
	set b7[5] = Ws
	call commonAddGold(Player(0), 10000)
	call commonAddGold(Player(1), 10000)
	call commonAddGold(Player(2), 10000)
	call commonAddGold(Player(3), 10000)
	call commonAddGold(Player(4), 10000)
	call commonAddLumber(Player(0), 10)
	call commonAddLumber(Player(1), 10)
	call commonAddLumber(Player(2), 10)
	call commonAddLumber(Player(3), 10)
	call commonAddLumber(Player(4), 10)
	call ChooseMoShi()
	set bj_forLoopAIndex = 0
	loop
		exitwhen bj_forLoopAIndex >= 5
		if GetPlayerController(Player(bj_forLoopAIndex)) == MAP_CONTROL_USER and GetPlayerSlotState(Player(bj_forLoopAIndex)) == PLAYER_SLOT_STATE_PLAYING then
			call SaveStr(YDHT, GetHandleId(Player(bj_forLoopAIndex)), GetHandleId(Player(bj_forLoopAIndex)), GetPlayerName(Player(bj_forLoopAIndex)))
			call SaveStr(YDHT, GetHandleId(Player(bj_forLoopAIndex)), GetHandleId(Player(bj_forLoopAIndex)) * 2, GetPlayerName(Player(bj_forLoopAIndex)))
		endif
		set bj_forLoopAIndex = bj_forLoopAIndex + 1
	endloop
	call YDWEPolledWaitNull(40.)
	call StartTimerBJ(A7[3], false, 90.)
	call CreateTimerDialogBJ(bj_lastStartedTimer, "邪教进攻倒计时：")
	call TimerDialogDisplay(bj_lastCreatedTimerDialog, true)
	set z7[3] = bj_lastCreatedTimerDialog
	call YDWEPolledWaitNull(120.)
	call TriggerExecute(ss)
	set hd = true
endfunction

function InitFamouses takes nothing returns nothing
	set ve[1] = 1328558411
	set xe[1] = 400
	set ye[1] = 20
	set ze[1] = 600
	set ve[2] = 1429221424
	set xe[2] = 350
	set ye[2] = 15
	set ze[2] = 730
	set ve[3] = 1160786002
	set xe[3] = 260
	set ye[3] = 12
	set ze[3] = 540
	set ve[4] = 1211117633
	set xe[4] = $FA
	set ye[4] = 18
	set ze[4] = 500
	set ve[5] = 1328558412
	set xe[5] = 310
	set ye[5] = 16
	set ze[5] = 750
	set ve[6] = 1328558413
	set xe[6] = $DC
	set ye[6] = 19
	set ze[6] = 700
	set ve[7] = 1328558414
	set xe[7] = 340
	set ye[7] = 17
	set ze[7] = 640
	set ve[8] = 1160786003
	set xe[8] = 320
	set ye[8] = $A
	set ze[8] = 780
	set ve[9] = 1160786004
	set xe[9] = $C8
	set ye[9] = 12
	set ze[9] = 550
	set ve[10] = 1311780913
	set xe[10] = 380
	set ye[10] = $B
	set ze[10] = 580
	set ve[11] = 1328558415
	set xe[11] = 280
	set ye[11] = $E
	set ze[11] = 800
endfunction

function InitBosses takes nothing returns nothing
	set Ae[1] = 1227896898
	set Ae[2] = 1227896665
	set Ae[3] = 1227896666
	set Ae[4] = 1227896880
	set Ae[5] = 1227896881
	set Ae[6] = 1227896882
	set Ae[7] = 1227896883
	set Ae[8] = 1227896884
	set Ae[9] = 1227896885
	set Ae[10] = 1227896886
	set Ae[11] = 1227896887
	set Ae[12] = 1227896888
	set Ae[13] = 1227896889
	set Ae[14] = 1227896897
	set Ae[15] = 1227896911
	set Ae[16] = 1227896899
	set Ae[17] = 1227896900
	set Ae[18] = 1227896901
	set Ae[19] = 1227896902
	set Ae[20] = 1227896903
	set Ae[21] = 1227896904
	set Ae[22] = 1227896905
	set Ae[23] = 1227896906
	set Ae[24] = 1227896907
	set Ae[25] = 1227896908
	set Ae[26] = 1227896909
	set Ae[27] = 1227896910
	set Ae[28] = 1227896912
endfunction

function InitHerbs takes nothing returns nothing
	set YaoCao[1] = 'I07F'
	set YaoCao[2] = 'I07G'
	set YaoCao[3] = 'I07E'
	set YaoCao[4] = 'I076'
	set YaoCao[5] = 'I077'
	set YaoCao[6] = 'I078'
	set YaoCao[7] = 'I079'
	set YaoCao[8] = 'I07B'
	set YaoCao[9] = 'I07A'
	set YaoCao[10] = 'I07C'
	set YaoCao[11] = 'I07D'
	set YaoCao[12] = 'I07H'
endfunction

function InitEquipments takes nothing returns nothing
	//衣服清单
	set ZhuangBei[1] = 'I022' // 布衣
	set ZhuangBei[2] = 'I01T' // 彩衣
	set ZhuangBei[3] = 'I01H' // 虎皮衣
	set ZhuangBei[4] = 'I01G' // 蛇皮裘
	set ZhuangBei[5] = 'I017' // 开阳衣
	set ZhuangBei[6] = 'I014' // 烈火衣
	set ZhuangBei[7] = 'I01O'
	set ZhuangBei[8] = 'I04E'
	set ZhuangBei[9] = 'I09Z'
	set ZhuangBei[10] = 'I00O'
	set ZhuangBei[11] = 'I00F'
	set ZhuangBei[12] = 'I00G'
	set ZhuangBei[13] = 'I0AL'
	set ZhuangBei[14] = 'I090'
	//饰品清单
	//白字
	set ShiPin[1] = 'I023' // 护身符
	set ShiPin[2] = 'I023' // 护身符
	set ShiPin[3] = 'I01U' // 纱绒护腕
	set ShiPin[4] = 'I01V' // 苍蟒护腕
	set ShiPin[5] = 'I01W' // 传家符
	set ShiPin[6] = 'I01X' // 琥珀项链
	set ShiPin[7] = 'I01Y' // 水碧护符
	set ShiPin[8] = 'I01Z' // 闪避护符
	set ShiPin[9] = 'I01I' // 星云戒指
	set ShiPin[10] = 'I01J'
	set ShiPin[11] = 'I01K'
	set ShiPin[12] = 'I015'
	set ShiPin[13] = 'I018'
	set ShiPin[14] = 'I019'
	set ShiPin[15] = 'I01A'
	set ShiPin[16] = 'I01B'
	set ShiPin[17] = 'I01C'
	set ShiPin[18] = 'I01D'
	//蓝字
	set ShiPin[19] = 'I01M'
	set ShiPin[20] = 'I011'
	set ShiPin[21] = 'I012'
	set ShiPin[22] = 'I01Q'
	set ShiPin[23] = 'I01R'
	set ShiPin[24] = 'I01O'
	set ShiPin[25] = 'I01P'
	set ShiPin[26] = 'I00Y'
	set ShiPin[27] = 'I00Z'
	set ShiPin[28] = 'I00R'
	set ShiPin[29] = 'I00S'
	set ShiPin[30] = 'I00T'
	set ShiPin[31] = 'I00U'
	set ShiPin[32] = 'I00V'
	set ShiPin[33] = 'I00W'
	//紫字
	set ShiPin[34] = 'I00H'
	set ShiPin[35] = 'I00I'
	set ShiPin[36] = 'I00J'
	set ShiPin[37] = 'I00K'
	set ShiPin[38] = 'I00L'
	set ShiPin[39] = 'I00M'
	set ShiPin[40] = 'I00N'
	//红字
	set ShiPin[41] = 'I08W'
	set ShiPin[42] = 'I08X'
	set ShiPin[43] = 'I08Y'
	set ShiPin[44] = 'I08Z'
	
	
	// 地图等级奖励物品id
	// 3级奖励
	set mapLevelReward[1] = 'I06H' 
	set mapLevelReward[2] = 'I01X' 
	set mapLevelReward[3] = 'I01U' 
	// 5级奖励
	set mapLevelReward[4] = 'I02T' 
	set mapLevelReward[5] = 'I01P' 
	set mapLevelReward[6] = 'I01G' 
	set mapLevelReward[7] = 'I01M' 
	// 8级奖励
	set mapLevelReward[8] = 'I01A' 
	set mapLevelReward[9] = 'I01C' 
	set mapLevelReward[10] = 'I01B' 
	// 10级奖励
	set mapLevelReward[11] = 'I019' 
	set mapLevelReward[12] = 'I00Z' 
	set mapLevelReward[13] = 'I010' 
	set mapLevelReward[14] = 'I00X' 
	set mapLevelReward[15] = 'I00Y' 
	// 11级奖励
	set mapLevelReward[16] = 'I06Z' 
	set mapLevelReward[17] = 'I071' 
	set mapLevelReward[18] = 'I02K' 
	set mapLevelReward[19] = 'I070' 
	// 12级奖励
	set mapLevelReward[20] = 'I0AM' 
	set mapLevelReward[21] = 'I01D' 
	set mapLevelReward[22] = 'I01J' 
	// 14级奖励
	set mapLevelReward[23] = 'I0E9' 
	
endfunction

//门派武功
function InitDenominationSkills takes nothing returns nothing
	set udg_menpainame[1] = "少林派"
	set denomFirst[1] = 'A05G'
	set denomThird[1] = 'A000'
	set denomSecond[1] = 'A05K'
	set denomFourth[1] = 'A05O'
	set denomFifth[1] = 'S000'
	set udg_menpainame[2] = "古墓派"
	set denomFirst[2] = 'A09E'
	set denomThird[2] = 'A09J'
	set denomSecond[2] = 'A09M'
	set denomFourth[2] = 'A09T'
	set denomFifth[2] = 'A09U'
	set udg_menpainame[3] = "丐帮"
	set denomFirst[3] = 'A0C9'
	set denomThird[3] = 'A0CB'
	set denomSecond[3] = 'A0C8'
	set denomFourth[3] = 'A0CA'
	set denomFifth[3] = 'A0DI'
	set udg_menpainame[4] = "华山派"
	set denomFirst[4] = 'A08Y'
	set denomThird[4] = 'A08W'
	set denomSecond[4] = 'A08X'
	set denomFourth[4] = 'A037'
	set denomFifth[4] = 'A091'
	set udg_menpainame[5] = "全真教"
	set denomFirst[5] = 'A0CF'
	set denomThird[5] = 'A0DA'
	set denomSecond[5] = 'A0CM'
	set denomFourth[5] = 'A0CH'
	set denomFifth[5] = 'A0DE'
	set udg_menpainame[6] = "血刀门"
	set denomFirst[6] = 'A0CI'
	set denomThird[6] = 'A0CJ'
	set denomSecond[6] = 'A0CN'
	set denomFourth[6] = 'A0CK'
	set denomFifth[6] = 'A0DH'
	set udg_menpainame[7] = "恒山派"
	set denomFirst[7] = 'A021'
	set denomThird[7] = 'A01Z'
	set denomSecond[7] = 'A0CD'
	set denomFourth[7] = 'A023'
	set denomFifth[7] = 'A024'
	set udg_menpainame[8] = "峨眉派"
	set denomFirst[8] = 'A0C7'
	set denomThird[8] = 'A0C2'
	set denomSecond[8] = 'A0C5'
	set denomFourth[8] = 'A0C4'
	set denomFifth[8] = 'A0C6'
	set udg_menpainame[9] = "武当派"
	set denomFirst[9] = 'A04D'
	set denomThird[9] = 'A08S'
	set denomSecond[9] = 'A08R'
	set denomFourth[9] = 'A08Q'
	set denomFifth[9] = 'A08V'
	set udg_menpainame[10] = "星宿派"
	set denomFirst[10] = 'A0BP'
	set denomThird[10] = 'A0BS'
	set denomSecond[10] = 'A0BQ'
	set denomFourth[10] = 'A0BT'
	set denomFifth[10] = 'A0BV'
	set udg_menpainame[11] = "自由门派"
	set denomFirst[11] = 'AEfk'
	set denomThird[11] = 'AEfk'
	set denomSecond[11] = 'AEfk'
	set denomFourth[11] = 'AEfk'
	set denomFifth[11] = 'AEfk'
	set udg_menpainame[12] = "灵鹫宫"
	set denomFirst[12] = 'A02B'
	set denomThird[12] = 'A02C'
	set denomSecond[12] = 'A02F'
	set denomFourth[12] = 'A02G'
	set denomFifth[12] = 'A02H'
	set udg_menpainame[13] = "姑苏慕容"
	set denomFirst[13] = 'A02K'
	set denomThird[13] = 'A0CC'
	set denomSecond[13] = 'A02M'
	set denomFourth[13] = 'A02V'
	set denomFifth[13] = 'A02R'
	set udg_menpainame[14] = "明教"
	set denomFirst[14] = 'A030'
	set denomThird[14] = 'A032'
	set denomSecond[14] = 'A06R'
	set denomFourth[14] = 'A034'
	set denomFifth[14] = 'A07W'
	set udg_menpainame[15] = "衡山派"
	set denomFirst[15] = 'A04M'
	set denomThird[15] = 'A04N'
	set denomSecond[15] = 'A04P'
	set denomFourth[15] = 'A026'
	set denomFifth[15] = 'A04R'
	set udg_menpainame[16] = "神龙教"
	set denomFirst[16] = 'A04W'
	set denomThird[16] = 'A04Z'
	set denomSecond[16] = 'A051'
	set denomFourth[16] = 'A057'
	set denomFifth[16] = 'A059'
	set udg_menpainame[17] = "神龙教"
	set denomFirst[17] = 'A056'
	set denomThird[17] = 'A054'
	set denomSecond[17] = 'A04X'
	set denomFourth[17] = 'A057'
	set denomFifth[17] = 'A059'
	set udg_menpainame[18] = "泰山派"
	set denomFirst[18] = 'A08A'
	set denomThird[18] = 'A08B'
	set denomSecond[18] = 'A08E'
	set denomFourth[18] = 'A08G'
	// set denomFifth[18]='A08H' // 快活三剑太卡，不用
	set denomFifth[18] = 'A08G'
	set udg_menpainame[19] = "铁掌帮"
	set denomFirst[19] = 'A06Y'
	set denomThird[19] = 'A06Z'
	set denomSecond[19] = 'A07Y'
	set denomFourth[19] = 'A070'
	set denomFifth[19] = 'A0DP'
	set udg_menpainame[20] = "唐门"
	set denomFirst[20] = 'A098'
	set denomThird[20] = 'A09A'
	set denomSecond[20] = 'A0B0'
	set denomFourth[20] = 'A0B6'
	set denomFifth[20] = 'A0B1'
	set udg_menpainame[21] = "五毒教"
	set denomFirst[21] = 'A0BL'
	set denomThird[21] = 'A0DU'
	set denomSecond[21] = 'A0DT'
	set denomFourth[21] = 'A0DS'
	set denomFifth[21] = 'A0DR'
	set udg_menpainame[22] = "桃花岛"
	set denomFirst[22] = 'A0EE'
	set denomThird[22] = 'A0EG'
	set denomSecond[22] = 'A0EI'
	set denomFourth[22] = 'A0EK'
	set denomFifth[22] = 'A0EL'
	set udg_menpainame[23] = "野螺派"
	set denomFirst[23] = ZAO_LEI_PI
	set denomThird[23] = BA_MIAN_LING_LONG
	set denomSecond[23] = FAN_SHOU_QIAN_ZHU
	set denomFourth[23] = QIAN_KUN_YI_ZHI
	set denomFifth[23] = DA_GONG_GAO_CHENG
	set udg_menpainame[24] = "雪山派"
	set denomFirst[24] = XUE_SHAN_JIAN_FA
	set denomThird[24] = FENG_SHA_MANG_MANG
	set denomSecond[24] = JIN_WU_DAO_FA
	set denomFourth[24] = XUE_HUA_LIU_CHU
	set denomFifth[24] = WU_WANG_SHEN_GONG
	set udg_menpainame[25] = "汝阳王府"
	set denomFirst[25] = TOU_KAN_TOU_XUE
	set denomThird[25] = 'AEfk'
	set denomSecond[25] = 'AEfk'
	set denomFourth[25] = XUAN_MING_SHEN_ZHANG
	set denomFifth[25] = JIA_YI_SHEN_GONG
	set udg_menpainame[26] = "嵩山派"
	set denomFirst[26] = SONG_SHAN_JIAN_FA
	set denomThird[26] = ZI_WU_SHI_ER_JIAN
	set denomSecond[26] = HAN_BING_SHEN_ZHANG
	set denomFourth[26] = WU_MING_NEI_GONG
	set denomFifth[26] = DA_SONG_YANG_SHEN_ZHANG
endfunction

function InitSkillBooks takes nothing returns nothing
	set udg_jianghu[1] = 'I03J'
	set udg_jianghu[2] = 'I03H'
	set udg_jianghu[3] = 'I02V'
	set udg_jianghu[4] = 'I02U'
	set udg_jianghu[5] = 'I03G'
	set udg_jianghu[6] = 'I02Z'
	set udg_jianghu[7] = 'I03I'
	set udg_jianghu[8] = 'I02X'
	set udg_jianghu[9] = 'I02Y'
	set udg_jianghu[10] = 'I03K'
	set udg_jianghu[11] = 'I03D'
	set udg_jianghu[12] = 'I03L'
	set udg_jianghu[13] = 'I030'
	set udg_jianghu[14] = 'I031'
	set udg_jianghu[15] = 'I03E'
	set udg_jianghu[16] = 'I033'
	set udg_jianghu[17] = 'I02W'
	set udg_jianghu[18] = 'I03F'
	
	set udg_juexue[1] = 'I039'
	set udg_juexue[2] = 'I034'
	set udg_juexue[3] = 'I038'
	set udg_juexue[4] = 'I037'
	set udg_juexue[5] = 'I03B'
	set udg_juexue[6] = 'I032'
	set udg_juexue[7] = 'I035'
	set udg_juexue[8] = 'I036'
	set udg_juexue[9] = 'I03C'
	set udg_juexue[10] = 'I03A'
	set udg_juenei[1] = 'I03S'
	set udg_juenei[2] = 'I03O'
	set udg_juenei[3] = 'I03T'
	set udg_juenei[4] = 'I03Q'
	set udg_juenei[5] = 'I03M'
	set udg_juenei[6] = 'I03P'
	set udg_juenei[7] = 'I03U'
	set udg_juenei[8] = 'I03R'
	
	set udg_canzhang[1] = 'I065'
	set udg_canzhang[2] = 'I061'
	set udg_canzhang[3] = 'I066'
	set udg_canzhang[4] = 'I064'
	set udg_canzhang[5] = 'I067'
	set udg_canzhang[6] = 'I062'
	set udg_canzhang[7] = 'I069'
	set udg_canzhang[8] = 'I060'
	set udg_canzhang[9] = 'I068'
	set udg_canzhang[10] = 'I063'
	set udg_canzhang[11] = 'I0CW'
	

	set udg_qiwu[1] = 'I0C2'
	set udg_qiwu[2] = 'I0C3'
	set udg_qiwu[3] = 'I0C4'
	set udg_qiwu[4] = 'I0C5'
	set udg_qiwu[5] = 'I0C6'
	set udg_qiwu[6] = 'I0C8'
	set udg_qiwu[7] = 'I0C9'
	set udg_qiwu[8] = 'I0CA'
	set udg_qiwu[9] = 'I0CB'
	set udg_qiwu[10] = 'I0CC'
	set udg_qiwu[11] = 'I0CD'
	set udg_qiwu[12] = 'I0CJ'
	set udg_qiwu[13] = 'I0CT'
	set udg_qiwu[14] = 'I0CU'
	set udg_qiwu[15] = 'I0CV' 
	
	set	udg_dan[1] = 'I06Y'
	set	udg_dan[2] = 'I071'
	set	udg_dan[3] = 'I06W'
	set	udg_dan[4] = 'I074'
	set	udg_dan[5] = 'I06V'
	set	udg_dan[6] = 'I075'
	set	udg_dan[7] = 'I073'
	set	udg_dan[8] = 'I072'
	set	udg_dan[9] = 'I070'
	set	udg_dan[10] = 'I06X'
	set	udg_dan[11] = 'I06Z'

	set udg_weapon[1] = 'I04F'
	set udg_weapon[2] = 'I00P'
	set udg_weapon[3] = 'I00Q'
	set udg_weapon[4] = 'I01L'
	set udg_weapon[5] = 'I01N'
	set udg_weapon[6] = 'I00X'
	set udg_weapon[7] = 'I00C'
	set udg_weapon[8] = 'I00D'
	set udg_weapon[9] = 'I00B'
	set udg_weapon[10] = 'I01F'
	set udg_weapon[11] = 'I01S'
	set udg_weapon[12] = 'I020'
	set udg_weapon[13] = 'I01E'
	set udg_weapon[14] = 'I021'
	set udg_weapon[15] = 'I016'
	set udg_weapon[16] = 'I013'
	set udg_weapon[17] = 'I08V'
	set udg_weapon[18] = 'I097'
	set udg_weapon[19] = 'I098'
	set udg_weapon[20] = 'I099'
	set udg_weapon[21] = 'I09A'
	set udg_weapon[22] = 'I09B'
	set udg_weapon[23] = 'I09C'
	set udg_weapon[24] = 'I09D'
	set udg_weapon[25] = 'I0DK'
	set udg_weapon[26] = 'I0DU'
	set udg_weapon[27] = 'I0DY'
	set udg_weapon[28] = 'I0DZ'
	set udg_weapon[29] = 'I0E0'
	set udg_weapon[30] = 'I0E2'
endfunction

function InitKillingTaskCreatures takes nothing returns nothing
	//阳寿已尽任务怪
	set udg_yangshou[1] = 'odoc'
	set udg_yangshou[2] = 'orai'
	set udg_yangshou[3] = 'hsor'
	set udg_yangshou[4] = 'nbdw'
	set udg_yangshou[5] = 'ndrw'
	set udg_yangshou[6] = 'ndqs'
	set udg_yangshou[7] = 'nsqo'
	set udg_yangshou[8] = 'nhrr'
	set udg_yangshou[9] = 'nomg'
	set udg_yangshou[10] = 'nubw'
	set udg_yangshou[11] = 'nrzb'
	set udg_yangshou[12] = 'nfpu'
	set udg_yangshou[13] = 'ngh2'
	set udg_yangshou[14] = 'nfsp'
	set udg_yangshou[15] = 'nmgd'
	set udg_yangshou[16] = 'uktn'
	set udg_yangshou[17] = 'nsrh'
	set udg_yangshou[18] = 'hspt'
	set udg_yangshou[19] = 'n00D'
	set udg_yangshou[20] = 'Hmkg'
	set udg_yangshou[21] = 'nfpc'
endfunction

// 单多通门派存档校正位数
function replenishSaveStr takes string oldSaveStr returns string newSaveStr
	if StringLength(oldSaveStr) < DENOMINATION_NUMBER then
		loop
			exitwhen StringLength(oldSaveStr) == DENOMINATION_NUMBER
			// body
			set oldSaveStr = oldSaveStr + "0"
		endloop
	endif
	if StringLength(oldSaveStr) > DENOMINATION_NUMBER then
		set oldSaveStr = SubString(oldSaveStr, 0, DENOMINATION_NUMBER)
	endif
	return oldSaveStr
endfunction

// 计算通关门派数量
function calMpCount takes integer i returns nothing
	local integer j = 0
	local integer msCount = 0 // 多通门派数量
	local integer ssCount = 0 // 单通门派数量
	local integer parentId = 1 + GetPlayerId(Player(i))
	// 截取存档，相加
	loop
		exitwhen j > DENOMINATION_NUMBER - 1
		// body
		set msCount = msCount + S2I(SubString(manySuccess[i], j, j + 1))
		set j = j + 1
	endloop
	set j = 0
	loop
		exitwhen j > DENOMINATION_NUMBER - 1
		// body
		set ssCount = ssCount + S2I(SubString(singleSuccess[i], j, j + 1))
		set j = j + 1
	endloop
	
	
	// 单通奖励
	if ssCount >= 1 then
		// 双倍积分
		set extraDoubleJf[i] = 2
		call SetPlayerTechResearched(Player(i), 'R007', 1)
	endif
	if ssCount >= 5 then
		call SetPlayerTechResearched(Player(i), 'R008', 1)
	endif
	if ssCount >= 8 then
		call SetPlayerTechResearched(Player(i), 'R009', 1)
	endif
	if ssCount >= 11 then
		// 积分兑换奇武次数加1
		set jfQiWuLimit[i] = 4 // 角标0开始
		call SetPlayerTechResearched(Player(i), 'R00A', 1)
	endif
	if ssCount >= 18 then
		call SetPlayerTechResearched(Player(i), 'R00B', 1)
	endif
	
	// 多通奖励
	if msCount >= 2 then
		// 1w金币
		call commonAddGold(Player(i), 10000)
		call SetPlayerTechResearched(Player(i), 'R00C', 1)
	endif
	if msCount >= 5 then
		// 25木头
		call commonAddLumber(Player(i), 25)
		call SetPlayerTechResearched(Player(i), 'R00D', 1)
	endif	
	if msCount >= 8 then
		// 额外100移速
		set extraSpeed[i] = 100
		call SetPlayerTechResearched(Player(i), 'R00E', 1)
	endif
	if msCount >= 11 then
		// 特攻加5
		set special_attack[i + 1] = special_attack[i + 1] + 5
		call SetPlayerTechResearched(Player(i), 'R00F', 1)
	endif
	if msCount >= 18 then
		// 守家积分加300
		set shoujiajf[i + 1] = shoujiajf[i + 1] + 300
		call SetPlayerTechResearched(Player(i), 'R00G', 1)
	endif
	// 通关门派存到哈希表，parentId从1开始
	call SaveInteger(YDHT, parentId, StringHash("多通门派数量"), msCount)
	call SaveInteger(YDHT, parentId, StringHash("单通门派数量"), ssCount)
	
	
endfunction

// 初始化服务器存档
function InitGlobalSave takes nothing returns nothing
	local integer i = 0 
	local integer j = 0 
	local integer a = 0
	
	// 获取全局存档
	set admin = DzAPI_Map_GetMapConfig("admin") // 测试码开关
	if admin == "" then
		set admin = "0"
	endif
	// 积分倍数全局存档
	set jfBeishu = DzAPI_Map_GetMapConfig("jfBeishu")
	
	set priKey = DzAPI_Map_GetMapConfig("priKey")
	
	loop
		exitwhen i > 4
		set extraDoubleJf[i] = 1 // 无额外双倍积分
		// set extraSpeed[i] = 0 // 无额外移速
		set manySuccess[i] = DzAPI_Map_GetStoredString(Player(i), "manySuccess") // 获取多通门派存档
		set singleSuccess[i] = DzAPI_Map_GetStoredString(Player(i), "singleSuccess") // 获取单通门派存档
		// 出bug补档
		set singleSuccess[i] = replenishSaveStr(singleSuccess[i])
		set manySuccess[i] = replenishSaveStr(manySuccess[i])
		set udg_zdl[i] = DzAPI_Map_GetStoredInteger(Player(i), "zdl") // 获取战斗力存档
		set udg_jf[i] = DzAPI_Map_GetStoredInteger(Player(i), "jf") // 获取积分
		set udg_success[i] = DzAPI_Map_GetStoredInteger(Player(i), "success") // 获取通关次数
		set max_damage[i] = DzAPI_Map_GetStoredReal(Player(i), "maxDamage") // 获取最高伤害
		set bonus_wugong[i] = DzAPI_Map_GetStoredReal(Player(i), "wugong") // 获取武功伤害加成
		set bonus_baoshang[i] = DzAPI_Map_GetStoredReal(Player(i), "baoshang") // 获取爆伤加成
		// 积分购买武功加成和爆伤上限30%，超过视为作弊，不加伤害
		if bonus_wugong[i] > 0.3 then
			set bonus_wugong[i] = 0
			call BJDebugMsg("伤害加成超过30%")
		endif 
		if bonus_baoshang[i] > 0.3 then
			set bonus_baoshang[i] = 0
			call BJDebugMsg("伤害加成超过30%")
		endif
		// 伤害加成加到武功伤害和暴击上
		set udg_shanghaijiacheng[i + 1] = udg_shanghaijiacheng[i + 1] + bonus_wugong[i]
		set udg_baojishanghai[i + 1] = udg_baojishanghai[i + 1] + bonus_baoshang[i]
		// 测试版本开局1000积分
		if testVersion then
			set udg_jf[i] = udg_jf[i] + 1000
		endif
		set jf_useMax[i] = 0 // 每局已用积分
		
		// 计算通关门派及奖励
		call calMpCount(i)	
		
		set i = i + 1
	endloop
	
endfunction
// 初始化测试人员的权限
function InitPriv takes nothing returns nothing
	local integer i = 0
	loop
		exitwhen i > 4
		if GetPlayerName(Player(i)) == "WorldEdit" or GetPlayerName(Player(i)) == "zeikale" or GetPlayerName(Player(i)) == "zeikala" or GetPlayerName(Player(i)) == "非我莫属xq" or GetPlayerName(Player(i)) == "苍穹而降" or GetPlayerName(Player(i)) == "晓窗临风" or GetPlayerName(Player(i)) == "沫Mu" or GetPlayerName(Player(i)) == "wenhuang" then
			if admin == "0" or testVersion then
				set udg_isTest[i] = true
				set talent_flag[i + 1] = 1
				set tiezhang_flag[i + 1] = 1
				set tangmen_flag[i + 1] = 1
				set mall_addition[i + 1] = 1
				set level_award[i + 1] = 1
				// set extraDoubleJf[i] = 2 // 额外双倍积分
				call DisplayTextToPlayer(Player(i), 0, 0, "|Cff008C00开|r|Cff088f00启|r|Cff119300了|r|Cff1a9700天|r|Cff239b00赋|r|Cff2b9f00、|r|Cff34a300铁|r|Cff3da700掌|r|Cff46ab00帮|r|Cff4faf00和|r|Cff57b300唐|r|Cff60b700门|r|Cff69bb00的|r|Cff72bf00权|r|Cff7bc300限|r|Cff83c700，|r|Cff8ccb00开|r|Cff95cf00启|r|Cff9ed300双|r|Cffa7d700倍|r|Cffafdb00积|r|Cffb8df00分|r|Cffc1e300和|r|Cffcae700萌|r|Cffd3eb00新|r|Cffdbef00礼|r|Cffe4f300包|r|Cffedf700权|r|Cfff6fb00限|r")
			endif
		endif
		set i = i + 1
	endloop
endfunction

// 初始化玩家数量
function initPlayerCount takes nothing returns nothing
	local integer i = 1 
	loop
		exitwhen i > 12
		// body
		if GetPlayerController(ConvertedPlayer(i)) == MAP_CONTROL_USER and GetPlayerSlotState(ConvertedPlayer(i)) == PLAYER_SLOT_STATE_PLAYING then
			set udg_wanjiashu = udg_wanjiashu + 1
		endif
		set i = i + 1
	endloop
	call BJDebugMsg("|CffFF0000玩家数量|r：" + I2S(udg_wanjiashu))
endfunction

function InitGlobalVariables takes nothing returns nothing
	call InitFamouses() //初始化名门
	call InitBosses() //初始化BOSS
	call InitHerbs() //初始化草药
	call InitEquipments() //初始化装备
	call InitDenominationSkills() //初始化门派武功
	call InitSkillBooks() //初始化武功书
	call InitKillingTaskCreatures() //初始化阳寿已尽任务怪
	call InitGlobalSave() // 初始化服务器存档
	call InitPriv() // 初始化测试权限
	call initPlayerCount() // 初始化玩家数量
endfunction




/*
* 门派触发器
*/
function MenPai_Trigger takes nothing returns nothing
	call EMei_Trigger() //峨眉武功触发
	call GaiBang_Trigger() //丐帮武功触发
	call GuMu_Trigger() //古墓武功触发
	call HuaShan_Trigger() //华山武功触发
	call HengShan_Trigger() //恒山武功触发
	call HengShan2_Trigger() //衡山武功触发
	call LingJiuGong_Trigger() //灵鹫宫武功触发
	call MuRongJia_Trigger() //慕容世家武功触发
	call QuanZhen_Trigger() //全真武功触发
	call ShaoLin_Trigger() //少林武功触发
	call ShenLong_Trigger() //神龙教武功触发
	call TieZhang_Trigger() //铁掌帮武功触发
	call tangMenTrigger() //唐门武功触发
	call TaiShan_Trigger() //泰山派武功触发
	call VIPMingJiao_Trigger() //明教武功触发
	call WuDang_Trigger() //武当武功触发
	call XueDao_Trigger() //血刀门武功触发
	call XingXiu_Trigger() //星宿武功触发
	call initXueShan() // 初始化雪山变量
	call initRuYang() // 初始化汝阳变量
	call initRiYue() // 初始化日月神教变量
	
	call JiangHuNeiGong_Trigger() //江湖内功触发（含九阴、绝内）
	call JiangHuWuGong_Trigger() //江湖武功触发
	call JueShiWuGong_Trigger() //绝世武功触发
endfunction

//地图初始化
function main1 takes nothing returns nothing
	local trigger t
	local real life
	local integer itemID
	local integer i
	local integer cu
	local integer Du
	local version v
	local integer wu
	call MapStartCreateUnitsAndInitEnvironments() // 创建单位并初始化环境

	set i = 1
	loop
		exitwhen i >= 6
		set udg_shuxing[i] = 10
		set qiuhun[i] = 0
		set zhaoyangguo[i] = 0
		set linganran[i] = 0
		set touxiao[i] = 0
		set bihai[i] = 0
		set bibo_kill[i] = 0
		set aidacishu[i] = 0
		set udg_wuqishu[i] = 0
		set udg_yifushu[i] = 0
		set showDamage[i] = true
		set showEffect[i] = true
		set i = i + 1
	endloop

	call ExecuteFunc("mv")
	call ExecuteFunc("Pw")
	set i = 0
	set i = 0
	loop
		exitwhen(i > 16)
		set udg_jdds[i] = 0
		set udg_ldds[i] = 0
		set udg_xbds[i] = 0
		set udg_bqds[i] = 0
		set udg_dzds[i] = 0
		set udg_jwjs[i] = 0
		set juexuelingwu[i] = 1
		set udg_baojishanghai[i] = 1.5
		set udg_baojilv[i] = .03
		set shanghaihuifu[i] = 100.
		set shaguaihufui[i] = 200.
		set shengminghuifu[i] = 0
		set falihuifu[i] = 0
		set udg_lilianxishu[i] = 1.
		set udg_hashero[i] = false
		set udg_baoji[i] = false
		set udg_yiwang[i] = false
		
		set tide_rising[i] = false
		set wumingBaseCount[i] = 0
		set wumingCount[i] = 0
		set wumingStr[i] = 0
		set wumingAgi[i] = 0
		set wumingInt[i] = 0
		set R4[i] = DialogCreate()
		set Y4[i] = 1
		set udg_xinggeA[i] = 0
		set udg_xinggeB[i] = 0
		// 赞助相关
		set udg_vip[i] = 2 
		set udg_changevip[i] = 1
		set udg_elevenvip[i] = 1
		// 是否是测试人员
		set udg_isTest[i] = false
		
		set saveFlag[i] = false // 默认未保存存档
		// 初始奖励
		set bonus_wugong[i] = 0
		set bonus_baoshang[i] = 0
		// 初始化最高伤害
		set max_damage[i] = 0
		set wugongshu[i] = 11 // 11格
		set udg_zhemei[i] = 0
		
		set jfQiWuLimit[i] = 3 // 积分奇武限定兑换3次
		
		set chief[i] = 0 // 掌门称号
		set title0[i] = 0 // 称号1 1-30
		set title1[i] = 0 // 称号2 31-60
		set deputy[i] = 0 // 副职
		set master[i] = 0 // 大师
		
		set qimen_status[i] = 0 // 奇门术数标识
		set ateDenom[i] = 0 // 是否吞了专属
		set ateTianShu[i] = 0 // 是否吞了天书
		set qiankunCd[i] = false // 乾坤是否处理CD中

		set wuxing[i] = 9
		set jingmai[i] = 9
		set gengu[i] = 9
		set fuyuan[i] = 9
		set danpo[i] = 9
		set yishu[i] = 9
		set jianghuLevel[i] = 0
		if i >= 1 and i <= 5 then
			// set special_attack[i] = DzAPI_Map_GetMapLevel(Player(i - 1))
			// 特攻暂时改成:25 + 天赋树等级 * 2
			set special_attack[i] = 25
		endif
		set udg_runamen[i] = 0
		set D7[i] = 0
		set F7[i] = 0
		set G7[i] = 0
		set K7[i] = DialogCreate()
		set L7[i] = 0
		set O7[i] = 0
		set P7[i] = 0
		set wolfSkinCount[i] = 0
		set wolfSkinFlag[i] = 1
		set udg_revivetimer[i] = CreateTimer()
		set S7[i] = 0
		set udg_MaxDamage[i] = 0
		set d8[i] = 0
		set e8[i] = 0
		set shengwang[i] = 0
		set g8[i] = 0
		set h8[i] = 0
		set i8[i] = 0
		set j8[i] = 0
		set o8[i] = false
		set v8[i] = DialogCreate()
		set b8[i] = false
		set C8[i] = false
		set c8[i] = false
		set D8[i] = DialogCreate()
		set F8[i] = false
		set XNKL[i] = false
		set daxia[i] = false
		set G8[i] = false
		set H8[i] = false
		set I8[i] = false
		set l8[i] = false
		set J8[i] = 0
		set xiuxing[i] = 0
		set MM8[i] = 0
		set N8[i] = 0
		set O8[i] = 0
		set Z8[i] = false
		set d9[i] = false
		set e9[i] = false
		set f9[i] = CreateTimer()
		set h9[i] = false
		set i9[i] = 0
		set v9[i] = false
		set w9[i] = false
		set x9[i] = false
		set y9[i] = false
		set z9[i] = 0
		set A9[i] = 0
		set G9[i] = 0
		set H9[i] = 0
		set I9[i] = 0
		set l9[i] = 0
		set udg_shanghaijiacheng[i] = .0
		set udg_shanghaixishou[i] = 0
		set max_damage_absorb[i] = 0.8
		set T9[i] = false
		set LLguaiA[i] = 0
		set LLguaiE[i] = 0
		set LLguaiB[i] = 0
		set LLguaiC[i] = 0
		set LLguaiD[i] = 0
		set LLguaiF[i] = 0
		set LLguaiG[i] = 0
		set Z9[i] = CreateTimer()
		set ed[i] = false
		set fd[i] = CreateTimer()
		set jd[i] = 0
		set kd[i] = 0
		set qd[i] = 0
		set rd[i] = 0
		set ud[i] = 0
		set wugongxiuwei[i] = 0
		set xd[i] = 0
		set yd[i] = 0
		set Ad[i] = false
		set Bd[i] = false
		set Cd[i] = 0
		set cd[i] = false
		set Dd[i] = 0
		set Ed[i] = 0
		set Fd[i] = CreateGroup()
		set Gd[i] = 0
		set Id[i] = 0
		set ld[i] = 0
		set Jd[i] = 0
		set Kd[i] = 0
		set Ld[i] = 0
		set Md[i] = 0
		set Nd[i] = 0
		set Od[i] = 0
		set Pd[i] = 0
		set Qd[i] = 0
		set Rd[i] = false
		set Sd[i] = 0
		set Td[i] = 0
		set Ud[i] = 0
		set Vd[i] = 0
		set Wd[i] = 0
		set jiuazi[i] = 0
		set shoujiajf[i] = 0
		set ge[i] = false
		set he[i] = false
		set je[i] = DialogCreate()
		set te[i] = 0
		set ce[i] = 0
		set De[i] = false
		set Ee[i] = false
		set i = i + 1
	endloop
	//set udg_menpaineigong=DialogCreate()
	set udg_index = DialogCreate()
	set udg_nan = DialogCreate()
	// 初始化挑战模式弹窗
	set udg_tiaoZhan = DialogCreate()
	set i7 = CreateGroup()
	set udg_shanghaidanweizu = CreateGroup()
	set udg_boshu = 1
	set w7 = CreateGroup()
	set i = 0
	loop
		exitwhen(i > 5)
		set A7[i] = CreateTimer()
		set i = i + 1
	endloop
	set ShiFouShuaGuai = true
	set i = 0
	loop
		exitwhen(i > 100)
		set I7[i] = 'AEfk'
		set i = i + 1
	endloop
	set i = 0
	loop
		exitwhen(i > DENOMINATION_NUMBER)
		set udg_menpainame[i] = "未加入"
		set denomFirst[i] = 'AEfk'
		set denomSecond[i] = 'AEfk'
		set denomThird[i] = 'AEfk'
		set denomFifth[i] = 'AEfk'
		set denomFourth[i] = 'AEfk'
		set nd[i] = 0
		set od[i] = 0
		set i = i + 1
	endloop
	set pd[1] = 2000
	set pd[2] = 2000
	set pd[3] = 2000
	set pd[4] = 5000
	set pd[5] = 5000
	set pd[6] = 5000
	set pd[7] = 15000
	set pd[8] = 15000
	set pd[9] = 15000
	set pd[10] = 500000
	
	set i = 0
	loop
		exitwhen(i > $A)
		set m8[i] = false
		set q8[i] = 'crys'
		set yongdanshu[i] = 0
		set i = i + 1
	endloop
	set i = 0
	loop
		exitwhen(i > $D)
		set udg_blgg[i] = 0
		set udg_blwx[i] = 0
		set udg_bljm[i] = 0
		set udg_blfy[i] = 0
		set udg_bldp[i] = 0
		set udg_blys[i] = 0
		set i = i + 1
	endloop
	set xianglongGroup = CreateGroup()
	set k9 = CreateGroup()
	set r9 = CreateGroup()
	set s9 = CreateGroup()
	set i = 0
	loop
		exitwhen(i > 20)
		set udg_jueneishxs[i] = 0
		set udg_jueneishjc[i] = 0
		set udg_jueneiminjie[i] = 0
		set udg_jueneijxlw[i] = 0
		set udg_jueneibaojilv[i] = 0
		set i = i + 1
	endloop
	set i = 0
	loop
		exitwhen(i > 7)
		set Hd[i] = CreateTimer()
		set i = i + 1
	endloop
	set i = 0
	loop
		exitwhen(i > 15)
		set xe[i] = 0
		set ye[i] = 0
		set ze[i] = 0
		set i = i + 1
	endloop
	set Fe = CreateGroup()
	//刚进入地图
	set lh = CreateTrigger()
	call TriggerRegisterTimerEventSingle(lh, .1)
	call TriggerAddAction(lh, function Zw)
	
	call InitGlobalVariables() //初始化全局变量
	
	call KeyInputSystem() //键盘输入系统
	call BlizzardEventSystem() //暴雪新API系统
	call SmeltingWeaponSystem()//决战江湖1.4之大辽金匠
	call CreateDestructables() //创建可破坏物
	call Cuns() //存储装备属性
	call CunWuGongS() //存储武功
	call najitest() //纳吉的测试代码
	
	set t = null
	set v = null
endfunction

function main2 takes nothing returns nothing
	call mallInit() // 商城逻辑初始化
	call GameLogic_Trigger() // 游戏逻辑触发器
	call GameDetail_Trigger() // 游戏细节处理
	// call VIP_Trigger() // VIP系统
	
	call InitTrig_ZhangMenSkill()
	
	call Equipment_Trigger() //装备属性触发器
	call MenPai_Trigger() //门派触发器
	call ZiZhi_Trigger() //自制武器触发器
	call ZhenFa_Trigger() //阵法触发器
	call TiaoZhan_Trigger() //挑战场触发器
	call QiWu_Trigger() //奇武触发器
	call TaoHuaDao_Trigger() //桃花岛触发器
	call Instances_Trigger() //副本和任务系统
	call Experiences_Trigger() //历练系统
	call ElixirSystem_Trigger() //丹药系统
	call Tasks_Trigger() //任务系统
	call checkActivityAddition() // 判断是否在活动期间
	call initEgg() // 彩蛋系统
	call initPassport() // 通行证系统
	
	
	call cleanItems() // 清除物品命令
	call enhanceDefense() // 难度七提升防御
	call npcHint() // NPC提示
	call showHealthPoint() //展示单位血量
	call talent() //天赋系统
	call EverySecond() // 记录游戏时间
	call initPetSkill() // 宠物技能
	call initUI() // 初始化UI
	
	call UnitAttack() // 注册单位攻击事件
	call UseAbility() // 注册使用技能事件
	call UnitDamage() // 注册任意单位伤害事件
	call UnitDeath() // 注册任意单位死亡事件
	call ItemEvent() // 注册物品相关事件
	
endfunction
