# coding : utf-8
class UsersController < ApplicationController
  def new
    @user = User.new
    @brands = ["게스","꾸즈","나이스클랍","디데무","디키즈","또마New","라인","로티니","르꼴레뜨","르샵","르윗","리바이스","리스트","리안뉴욕","리트머스","ㅁ","마인드브릿지","매그 앤 매그","메긴나잇브릿지","모비토","ㅂ","BNX(비앤엑스)","바닐라비","발렌시아","백패커스","밸리걸","버커루 ACC","버커루 진","베네통","벵갈빈티지New","보니알렉스","보브","브릿지11","비지트인뉴욕","비키Sale","ㅅ","수퍼드라이","숲","쉐인진","스위트숲","스테파넬","스프링필드","시슬리","써쓰데이아일랜드","씨Sale","씨씨콜렉트","ㅇ","ASK","애드혹","앤듀","어스앤뎀","에고이스트","에코플래닛","엔비에이","엠폴햄","예츠Sale","오조크Sale","온앤온","올리브데올리브","올리브핫스텁","옵트","잇미샤","ㅈ","잭앤질","쥬크","지바이게스","지오다노","지컷","지프","진스퀘어","질바이질스튜어트","ㅊ","칩먼데이","ㅋ","카살","카시바디","카이아크만","캘빈클라인진","캘빈클라인진 악세사리","커밍스텝","컨셉원","컬쳐콜","케네스레이디","코데즈컴바인","코인코즈","쿠아","퀵실버/록시","크럭스","크리스크리스티","클라이드","ㅌ","타스타스Sale","탑걸","탱커스","테이트","티니위니","티렌","틸버리","팀스폴햄","힐피거데님","ㅍ","팬콧","페이지플린Sale","폴햄","플라스틱 아일랜드","ㅎ","행텐","홀하우스","후부","흄","A","ab.f.z","B","BIKE REPAIR SHOP","BSX","D","DOHC","E","EnC","F","FRJ","G","G-Star raw","GGPX","H","H:CONNECT","J","JJ JIGOTT","jnB","K","KHOS","M","MLB","N","NII","S","SPICY COLOR","T","30 DAYS MARKET","TBJ","U","UGIZ","ETC","96NY(나인식스뉴욕)"]
    @branchs = ["롯데닷컴 본점","롯데닷컴 영등포점","롯데닷컴 청량리점","롯데닷컴 광복점","롯데아이몰 잠실점","롯데아이몰 노원점","롯데아이몰 부산본점","롯데아이몰 광주점","엘롯데 중동점","엘롯데 동래점","엘롯데 잠실점","엘롯데 구리점","엘롯데 포항점","엘롯데 영등포점","엘롯데 일산점","엘롯데 창원점","엘롯데 청량리점","엘롯데 안양점","엘롯데 울산점","엘롯데 관악점","엘롯데 안산점","엘롯데 상인점","엘롯데 강남점","엘롯데 인천점","엘롯데 전주점","엘롯데 노원점","엘롯데 부산본점","엘롯데 센텀시티점","엘롯데 미아점","엘롯데 대구점","엘롯데 광복점","엘롯데 분당점","엘롯데 대전점","엘롯데 김포공항점","엘롯데 부평점","엘롯데 평촌점","엘롯데 광주점","엘롯데 건대스타시티점","HMALL 미아점","HMALL 천호점","HMALL 코엑스점","HMALL 신촌점","HMALL 목동점","HMALL 부산점","신세계몰 본점","신세계몰 강남점","AK몰 분당점","AK몰 수원점"]
  end
  
  def guide
    if session[:village].nil?
      redirect_to root_path, :notice => "city"
    end
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to login_path, :notice => @user.username + "님 가입 감사드립니다!"
    else
      render :new
    end
  end
  
  def show
    @user = User.find params[:id]
    @collections = @user.collections

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end    
  end
  
  def edit
    @user = current_user
    @photos = @user.photos.order(:item_code)
  end
  
  def update
    photo = params[:photo]
    @photos = Photo.find(photo.keys)
    respond_to do |format|
      if Photo.update(photo.keys, photo.values)
        Item.association_to_all_photos
        format.html { redirect_to dashboard_path, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @photos.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # GET /villages
  # GET /villages.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
      format.csv { render csv: @users }
    end
  end
end