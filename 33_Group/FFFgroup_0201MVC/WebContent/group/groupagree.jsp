<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.group.model.*"%>
<html>
<head>
<meta charset="BIG5">
        <title>我要開團</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Bootstrap icons-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
        <link href="css/t33.css" rel="stylesheet" />
    </head>
    <body class="d-flex flex-column">
        <main class="flex-shrink-0">
            <!-- Navigation-->
            <script src="js/nav.js"></script>
            
            <!-- Page content-->
            <section class="py-5">
                <div class="container px-5">
                  <h3>開團須知</h3>
                    <!-- Contact form-->
                    <div class="accordion" id="accordionExample">
                        <div class="accordion-item">
                          <h2 class="accordion-header" id="headingOne">
                            <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                開團資訊
                            </button>
                          </h2>
                          <div id="collapseOne" class="accordion-collapse collapse show" aria-labelledby="headingOne" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                            <p>
                                <strong>開團名稱:</strong> 為必須輸入資訊, 簡短名稱讓人了解揪團內容<br>
                                <strong>開購內容:</strong> 輸入開團內容的資訊, 生動的介紹敘述越容易吸引人加入揪團<br>
                                <strong> 參考網址:</strong> 揪團的詳細說明網頁網址<br>
                                <strong>揪團時間:</strong> 設定揪團開始及結束日期時間, 開始日期(例:2019/05/08),可以不輸入。  開始時間, 下拉選取方式(00~23)。  結束日期(例:2021/05/08),可以不輸入, 有輸入時間到會自動關閉。  開始時間, 下拉選取方式(00~23)。<br>
                                <strong>開團最低量:</strong>如果有開團限制可以在此設定, 可以不輸入。<br>
                                <strong> 揪團圖檔:</strong> 新增開團時可設定一個圖檔, 如有多個圖檔可存檔完畢後, 透過修改方式繼續上傳。<br>
                            </p> 
                            </div>
                          </div>
                        </div>
                        <div class="accordion-item">
                          <h2 class="accordion-header" id="headingTwo">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                隱私權與個人資料保護政策聲明
                            </button>
                          </h2>
                          <div id="collapseTwo" class="accordion-collapse collapse" aria-labelledby="headingTwo" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                                <p>本隱私權政策聲明適用於XX科技股份有限公司((以下簡稱本公司)所提供的服務。在使用與瀏覽本網站時，您同意受本隱私權政策條款及條件所保護及拘束；如果您不同意，請不要使用或取得我們所提供的服務。您個人資料在符合本政策條款時，有些部分會被揭露予第三人並且被我們及第三人使用，您在註冊或上傳個人資料時透過接受隱私權政策，明示同意我們使用及揭露您個人資料。

                                    XX科技股份有限公司秉持落實個人資料保護及管理措施，遵循《個人資料保護法》所述之相關要求及保障個人資料當事人之權利，降低任何個人資料檔案受侵害之事件所可能帶來的衝擊，並持續運作及改善個人資料管理制度，特發布表聲明。</p>
                            </div>
                          </div>
                        </div>
                        <div class="accordion-item">
                          <h2 class="accordion-header" id="headingThree">
                            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseThree" aria-expanded="false" aria-controls="collapseThree">
                                個人資料之維護
                            </button>
                          </h2>
                          <div id="collapseThree" class="accordion-collapse collapse" aria-labelledby="headingThree" data-bs-parent="#accordionExample">
                            <div class="accordion-body">
                              <p>
                                XX將根據個人資料保護政策之目的收集、使用或揭露您提供的個  人資料。目的包括提供服務、儲存、分析、解決爭議、符合應適用的法令規定，以及符合XX的內部政策。
                                XX為合理達成上述目的，將傳輸您的個人資料給國內外XX的雇員、主管、董事、客戶（及其代理人）、供應商（主要是指IT提供者與財務與提供法律意見者）、有權機構、其他XX關係企業。無論如何，為遵守契約與法律義務，傳輸時會嚴守必要知悉的基礎，且該等第三人有與XX相仿的個資保護政策。
                                XX將遵循應適用的法令，於有限的期間內安全的處理、維持與儲存您的個人資料。
                                XX依靠您的個人資訊達成上述目的，因此，您應確保您提供的個人資料的精準、正確與完整。若您希望更正、更新或刪除您的個人資料，請您接洽XX個人資料保護窗口。
                                您可隨時發出通知XX個人資料保護窗口收回此同意。您認知此收回應向未來發生效力且僅影響XX於未來使用或揭露您的個人資料。
                                關於本同意書或任何相關事宜，若您對XX如何對待您的資料有任何問題，您可連繫XX個人資料保護窗口XXX@XXX.com.tw。
                                個人資料之蒐集與使用</p>
                            </div>
                          </div>
                        </div>
                        <div> 
                            <div class="accordion-item">
                                <h2 class="accordion-header" id="headingFour">
                                  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
                                    蒐集之特定目的
                                  </button>
                                </h2>
                                <div id="collapseFour" class="accordion-collapse collapse" aria-labelledby="headingFour" data-bs-parent="#accordionExample">
                                  <div class="accordion-body">
                                  <p>
                                    茲依據個人資料保護法之特定目的及個人資料之類別，
                                    ○○二 人事管理、○二○代理與仲介業務、○三一 全民健康保險、勞工保險、農民保險、國民年金保險或其他社會保險、○六九 契約、類似契約或其他法律關係事務、○九○  消費者、客戶管理與服務、一○七  採購與供應管理、一一七 就業安置、規劃與管理、一四五 僱用與服務管理、一六八 護照、簽證及文件證明處理、一八一  其他經營合於營業登記項目或組織章程所定之業務、一八二 其他諮詢與顧問服務、○六三  非公務機關依法定義務所進行個人資料之蒐集處理及利用、一○九  教育或訓練行政
                                    蒐集之個資類別
                                    姓名、身分證正面、特徵、家庭、教育、職業、健康檢查、聯絡方式、社會活動
                                    個資利用之期間、地區、對象及方式
                                    期間：您的個人資料將於與本公司契約期間及經您同意之期間被處理或利用。
                                    地區：XX科技股份有限公司(包括國內外關係企業)，及您提供服務派駐公司之場所。
                                    對象：本公司員工以及派駐公司之派遣業務相關人員（包含XX與要派公司）
                                    方式：本公司將透過數位檔案或實體紙本形式向您蒐集資料。
                                    您可透過親臨現場方式行使個人資料保護法第三條當事人權利規定，包含行使個人資料查詢、閱覽、複製本、補充、更正、刪除及停止蒐集、處理與利用之要求。
                                    若您無法同意「個人資料之維護」與「個人資料之蒐集與使用」將導致本公司日常業務無法正常進行，進而無法僱用您為本公司之派遣員工及推薦工作機會。
                                    本公司取得您的健康檢查資料係依據「職業安全衛生法」及其相關法令要求而實行。
                                    於您的在職年度，XX台灣及XX集團(非台灣之海外地區)會將您的姓名、身分證統一編號與Email作為『滿意度問卷調查』識別及聯絡之用，以供您自由回饋意見。
                                    您同意並向本公司保證，於求職時所提供之第三人資訊 (如緊急聯絡人、資歷查核相關人員等)，皆已取得當事人之同意。
                                  </p> 
                                  </div>
                                </div>
                              </div> 
                              <div class=" aaa">  
                                <input type="checkbox" name="checkbox-agree" id="box" class="custom" />
                                 <label for="box">我全部同意</label>                     
                                <button type="button" class="btn btn-primary" id="btn" disabled onclick="location.href='groupform.jsp'">建立表單</button>
                              </div>
                            </div>
                                </div>
                            </div>
                     
            </section>
            <script src="jquery/jquery-3.6.0.min.js"></script>
            <script>
           
              $('#box').on('change', function () {
                if ($('#box').prop('checked')) {
                  $('#btn').attr('disabled', false);
                }
                else {
                  $('#btn').attr('disabled', true);
                }
              })
            </script>
        </main>
        <!-- Footer-->
        <footer class="bg-dark py-4 mt-auto">
            <div class="container px-5">
                <div class="row align-items-center justify-content-between flex-column flex-sm-row">
                    <div class="col-auto"><div class="small m-0 text-white">Copyright &copy; Your Website 2021</div></div>
                    <div class="col-auto">
                        <a class="link-light small" href="#!">Privacy</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Terms</a>
                        <span class="text-white mx-1">&middot;</span>
                        <a class="link-light small" href="#!">Contact</a>
                    </div>
                </div>
            </div>
        </footer>
        <!-- Bootstrap core JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <!-- * *                               SB Forms JS                               * *-->
        <!-- * * Activate your form at https://startbootstrap.com/solution/contact-forms * *-->
        <!-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *-->
        <script src="https://cdn.startbootstrap.com/sb-forms-latest.js"></script>
    </body>
</html>
