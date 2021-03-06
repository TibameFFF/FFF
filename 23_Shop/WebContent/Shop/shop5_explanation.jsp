<%@page contentType="text/html; charset=UTF-8"%>

<!DOCTYPE html>
<html lang="zh-hant">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>購物說明</title>
    <link rel="stylesheet" href="vendors/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" integrity="sha384-SZXxX4whJ79/gErwcOYf+zWLeJdY/qpuqC4cAa9rOGUstPomtqpuNWT9wdPEn2fk" crossorigin="anonymous">
    <link rel="stylesheet" href="style/style.css">

</head>

<body class="container-fluid">
	<jsp:include page="pieces/header.jsp"></jsp:include> <!-- header -->
    <jsp:include page="pieces/search_bar.jsp"></jsp:include> <!-- search_bar -->
    <!------------- main page --------------->

    <main>
        <article class="explanation">
            <h2>一、購物說明</h2>
            <div>
                <h3>【約定條款】</h3>
                <p>在您進行線上購物服務前，請先詳細閱讀　線上購物約定條款</p>
                <h3>【購物流程】</h3>
                <p>註冊/登入帳號 → 選購商品 → 購物結帳 → 填寫資料與付款 → 訂購完成</p>
                <p>為保障會員權益和服務，購物前必須先加入成為會員，若您還不是會員，歡迎您立即以E-MAIL線上註冊或以社群帳號登入！</p>
                <p>※ 購物結帳</p>
                <p>在要購買的商品頁上先選擇購買數量，再點選「放入購物車」，即可繼續購買其他商品，挑選完所有商品後，點選頁面上的「我的購物車」功能選項，即可進入結帳頁面。</p>
                <p>※ 填寫資料與付款</p>
                <p>填寫正確詳細的收件者與信用卡資料，完成後請點選「確認送出」。</p>
                <p>※ 訂購完成</p>
                <p>付款完成後訂單即成立，您的電子信箱會即時收到訂單成立的通知信件，商品將於七個工作天內（不含週休及國定例假日）送達收件地址。</p>
                <h3>【訂單查詢】</h3>
                <p>當您完成訂購程序後，系統會發出「訂單確認通知函」到您的email信箱中，內含您的詳細訂購資訊及聯絡資料，此即代表您已經訂購成功。
                    若您要查詢訂單資料，請點選網頁右上方的「訂單查詢」功能，即可查詢到相關資料以及目前訂單的處理進度！各訂單狀態說明如下：
                </p>
                <p>● NEW（新訂單成立）：代表您的信用卡線上交易通過了銀行的認證，訂單已經正式成立。</p>
                <p>● INVOICED（訂單處理中）：代表客服人員已查詢到的您的訂單，正在處理中。</p>
                <p>● SHIPPED（商品已出貨）：代表您的商品已經出貨，正由宅配物流公司進行配送，商品會於訂單成立日起的七個工作天內（不含週休 及國定例假日）送達您指定的收件地址。</p>
                <p>● CLOSED（商品已到貨）：代表您的商品已經送達您指定的收件地址且已簽收。</p>
            </div>


            <h2>二、付款方式</h2>
            <div>
                <p>目前提供「信用卡一次付清」。</p>
                <h3>【信用卡線上刷卡】</h3>
                <p>信用卡線上刷卡付款：當您在結帳頁面進行信用卡相關資料填寫時，請務必詳實填寫正確資料，以利銀行做信用卡資料的審核。線上刷卡的資料傳輸均採用SSL憑證加密，有效保護您的資料安全。</p>
                <p>如您刷卡未成功主因為3D認證授權錯誤，請洽您的刷卡銀行，確認您的3D認證密碼或主動解除3D認證。</p>
                <h3>【發票開立】</h3>
                <p>訂單成立並完成付後，我們將立即開立發票並連同訂購商品，一起包裝、配送至您指定的收件地址。若您的訂單收件人寄送地址與訂購人不同，發票將在付款完成後立即開立，但不會隨貨一併附上，而是在商品出貨後14個工作天另行掛號寄出至訂購人聯絡地址。
                </p>
            </div>

            <h2>三、商品配送</h2>
            <div>
                <h3>【運費計算】</h3>
                <p>訂購商品總金額超過新台幣$2,000元(含)，免收取運費；未滿新台幣$2,000元時，消費者需自付運費新台幣$100元。</p>
                <h3>【出貨說明】</h3>
                <p>當線上訂購商品訂單成立並完成付款後，我們將會在付款完成後的2~3個工作天內(不含週休及國定例假日)
                <p>完成出貨，並宅配至您指定的收件地址，送達時間依宅配公司為主，為了保護商品的完整，我們會妥善包裝您所訂購的商品，收到貨後請立即開箱檢查，確認商品包裝完整無缺。</p>
                <p>若遇下列因素，將視個別情況安排到貨時間：</p>
                <p>＊訂購商品如需包裝服務者，將於3～5個工作天內出貨。</p>
                <p>＊訂購商品貨量不足，需另行調貨之訂單，將由客服人員另外通知確認出貨時間。</p>
                <p>＊訂購人／收件人資料不完整，將由客服人員確認後安排出貨時間。</p>
                <p>＊使用會員權益者，會員資格不符或輸入不完整者，將由客服人員確認後安排出貨時間。</p>
                <p>＊如遇颱風、地震等不可抗拒因素時，於上班日後2～3個工作天內出貨，實際到貨時間依統一速達配送時間為主。</p>
                <p>＊週年慶／雙11活動期間將於3～5個工作天內出貨，實際到貨時間依統一速達配送時間為主。</p>
                <p>＊農曆春節期間或連續假期到貨時間，依網站公告為主。</p>
                <p>＊如有上述未詳列之特殊狀況，將視個別由客服人員聯繫說明。</p>
            </div>


            <h2>四、售後服務</h2>
            <div>
                <h3>【取消訂單】</h3>
                <p>若您要取消訂單，請直接聯絡客服人員，並提供「訂單編號」與「訂購人姓名」，一收到您的需求，客服人員會即刻為您處理，並於完成後一個工作天內，以email的方式回覆您訂單取消的處理結果，收到回覆信件後，您亦可上網利用「訂單查詢」的功能，查詢目前訂單的處理狀況。
                </p>
                <h3>【退貨】</h3>
                <p>若您要辦理退貨，請於收到貨當日起7天鑑賞期(鑑賞期規範說明如下)內（含國定例假日）聯絡客服人員，我們會安排宅配公司於5個工作天內，到您指定的地點取貨。</p>
                <p>請注意，您所退回的商品內容必須保維持所有商品、贈品、附件、包裝、附隨文件或資料的完整性，如有實體發票則須連同發票一併退回，並且簽屬「退貨折讓單」等相關法令規定文件，否則本公司有權力拒絕您的退貨退款要求。
                </p>
                <p>退貨時，請您使用原包裝紙箱將欲辦理退貨之商品包裝妥當，若原紙箱已遺失，請使用其他完整紙箱包裝，切勿直接於原廠包裝上黏貼紙張或書寫文字。您要求退貨之商品若有缺件或是損毀，歐舒丹有權視損毀程度而折扣退款金額；為保障您的權益，若您所訂購的商品本身有瑕疵問題，須於收到商品後七天內向本公司請求退款或退換商品，本公司將全額退款給您，或提供無條件退換貨的售後服務。
                </p>
                <h3>【退款處理流程】</h3>
                <p>線上刷卡退款：</p>
                <p>物流寄回退貨商品，歐舒丹檢查所有商品、贈品、附件、包裝、附隨文件或資料的完整性後，將於7~10個工作天（不包含例假日）內完成刷退。但因各刷卡行結帳日不同之關係，實際入帳入還請洽詢您的銀行。</p>
                <h3>【換貨】</h3>
                <p>若您要辦理換貨，請於收到貨當日起7天鑑賞期(鑑賞期規範說明如下)內（含國定例假日）聯絡客服人員，我們會安排宅配公司於5個工作天內，到您指定的地點取貨。</p>
                <p>新品瑕疵須換貨：若您收到的新品有瑕疵或破損的狀況，您可享有無條件退換貨的售後服務，請於收到貨當日起7天鑑賞期內（含國定例假日）聯絡客服人員，我們會安排宅配公司於5個工作天內，到您指定的地點取回原商品貨並且更換新品給您。
                </p>
                <p>*** 換不同商品：若您收到訂購的商品後，想要更換其中任何一款商品，您必須先退回此次訂購的所有商品，取消此筆訂單，然後重新下訂一筆新的訂單，恕無法直接使用原訂單進行換貨。</p>
                <p>換貨時，請您使用原包裝紙箱將欲辦理換貨之商品包裝妥當，若原紙箱已遺失，請使用其他完整紙箱包裝，切勿直接於原廠包裝上黏貼紙張或書寫文字。您要求換貨之商品若有缺件或是損毀，歐舒丹有權視損毀程度而折扣退款金額；為保障您的權益，若您所訂購的商品本身有瑕疵問題，須於收到商品後七天內向歐舒丹請求退款或退換商品，歐舒丹將全額退款給您，或提供無條件退換貨的售後服務。
                </p>
                <h3>【鑑賞期規定】</h3>
                <p>根據消費者保護法之規定，本公司將提供您享有商品到貨次日起算七天鑑賞期的權益，前開期間係供您評估是否購買該商品，並非提供您試用該商品，您可在前開期間內要求退貨退款，但提醒您，所退回的商品內容必須保維持所有商品、贈品、附件、包裝、附隨文件或資料的完整性，如有實體發票則須連同發票一併退回，並且簽屬「退貨折讓單」等相關法令規定文件，否則，歐舒丹有權力拒絕您的退貨退款要求。
                </p>
                <h3>【個人資料安全】</h3>
                <p>您所留存的個人資料，本公司將依個人資料保護法及隱私權聲明蒐集、處理及利用，並善盡安全維護管理責任。有關個人資料蒐集之法定應告知事項，詳請參閱隱私權聲明及台灣歐舒丹官網會員服務條款。</p>
                <h3>【聯絡客服】</h3>
                <p>若您有任何疑問，可先參考網頁上常見問題的解答，或者可於上班時間聯絡客服人員，我們將竭誠為您服務，相關資訊如下：</p>
                <p>● 上班時間：週一至週五，AM 10:00～PM 18:00。國定例假日不上班。</p>
                <p>● 免付費客服專線：0800-087-654</p>
                <p>● 客服信箱：ec_info@goodproduct.com.tw</p>
            </div>

            <h2>五、常見問題</h2>
            <div>
                <h3>【訂單常見問題】</h3>
                <p>Ｑ：為何email信箱沒有收到「訂單確認通知函」？</p>
                <p>Ａ：請確認以下：</p>
                <p>● 請先確認您所輸入的個人帳號密碼是否正確。</p>
                <p>● 若您的個人資料有誤（例如：email帳號錯誤）或是訂購並未成功，也會造成「訂單確認通知函」無法寄達的問題，請點選網頁右上方
                    的「訂單查詢」功能來查詢您的交易記錄，若此筆交易紀錄成立，即表示訂購已完成，同時請檢查您所留的個人資料是否正確。 以上都無誤，卻還是無法收到訂單確認函，請直接與聯絡客服人員，由客服人員為您即時處理。
                </p>
                <h3>【付款＆發票常見問題】</h3>
                <p>Ｑ：我已經完成訂購並付款了，多久可以查到記錄？</p>
                <p>Ａ：完成訂購後，您可立即利用網站上的「訂單查詢」或「我的帳戶」功能中查詢到訂購記錄。</p>
                <p>Ｑ：查詢訂單狀態為授權失敗，我還需要付信用卡費嗎？</p>
                <p>Ａ：發生此狀況的原因可能是網路壅塞或是銀行系統機制問題等不明因素，導致系統並未接獲銀行回傳的訂單授權碼，故此筆訂單將視為無效，您不需要付此筆卡費，若您欲購買此商品，請重新下訂即可。</p>
                <p>Ｑ：為何當我使用信用卡線上訂購商品時，網頁會一直顯示交易失敗？</p>
                <p>Ａ：您可先聯絡我們的客服人員諮詢，若非系統故障，則有可能是您的信用卡有問題，麻煩請您洽詢您的信用卡發卡銀行。</p>
                <p>Ｑ：請問發票會寄到哪一個地址？</p>
                <p>Ａ：每筆訂單發票皆會隨著訂購商品宅配至您指定收件地址；若您的收件地址與訂購人聯絡地址不同，則發票將會寄至訂購人的聯絡地址。</p>
                <p>Ｑ：如果發票金額或統一編號錯誤，我該怎樣處理？</p>
                <p>Ａ：請立即聯絡客服人員，客服人員將會盡速為您處理。</p>
                <p>Ｑ：請問怎樣變更發票的開立方式？</p>
                <p>Ａ：請於結帳時於備註欄中註明；若已收到商品及發票，請立即聯絡客服人員，客服人員將會盡速為您處理。</p>
                <p>Ｑ：如果我在七天商品鑑賞期內要求退貨，但尚未收到發票，我該怎樣處理？</p>
                <p>Ａ：在七天商品鑑賞期內，發票是由我們為您保存，因發票尚未寄送給您，因此退貨時不需附上發票，但您需先聯絡客服人員處理並提供訂單編號；若您提前收到發票，退貨時就必須一併附上。</p>
                <p>Ｑ：發票可以指定開立日期、金額或更改品名嗎？</p>
                <p>Ａ：根據法令規定，發票上的資訊會根據您實際消費的日期、商品名稱和金額開立，恕無法指定更改任何內容，謝謝您。</p>
                <p>Ｑ：我可以使用網路虛擬信用卡消費嗎？</p>
                <p>Ａ：為了確保交易的安全性和信用卡認證作業的時效性，進行線上購物時，除了輸入卡號外，您還需要輸入卡片背面未三碼，網路虛擬信用卡無末三碼可輸入以資認證，因此無法使用網路虛擬信用卡消費。</p>
                <h3>【配送常見問題】</h3>
                <p>Ｑ：為何已經過了7個工作天，我還是沒有收到商品呢？</p>
                <p>Ａ：請您先利用網頁右上方的「訂單查詢」功能查詢目前訂單狀態，若顯示「配送完成」，則代表商品已送達您指定的收件地址，請確認是否有其他人代收（親人、室友、管理員等）。</p>
                <p>若訂單狀態顯示「配送中」，可能是商品在運送過程中產生異常問題，例如無人簽收、地址有誤、電話沒人接，煩請聯絡客服人員，客服人員將親自為您查詢處理。
                <p>若為預購商品，則配送時間不在七個工作天的限制內，請參閱該商品的頁面說明，以確認實際出貨日期。</p>
                <p>Ｑ：請問我可以指定收貨的時段和日期嗎？</p>
                <p>Ａ：由於受限物流配送的作業時間和流程，目前恕無法提供「指定收貨時段和日期」的服務，因此訂購時，請填寫可於配送時間內收貨的地點和時間。</p>
                <p>Ｑ：若我臨時要變更收件地址，請問要如何處理？</p>
                <p>Ａ：若您已完成訂購程序，訂單已成立，將無法查詢訂單進行直接修改的動作，請您連絡客服人員，由客服人員為您處理。</p>
                <h3>【退貨／換貨常見問題】</h3>
                <p>Ｑ：我只要一申請退貨，你們就會立即退款給我嗎？</p>
                <p>Ａ：只要您完成所有的退貨手續，我們也確實收到您退回的商品，且商品是完整無損的狀態，客服人員就會立即為您辦理退款手續。</p>
                <p>Ｑ：如果我只有對部分商品不滿意，請問可以部分退貨退款嗎？</p>
                <p>Ａ：很抱歉！由於銀行端的作業無法配合部分退款，故我們將無法接受訂單的部分退貨退款！若您有此需求，須先取消原訂單，並且重新下訂，後續我們會請宅配公司連絡您處理退貨事宜。</p>
            </div>
        </article>



    </main>

    <div id="to_top"><a href="#top"><i class="fas fa-chevron-circle-up fa-2x"></i></a></div>
    <script src="vendors/jquery-3.6.0.min.js"></script>
    <script src="vendors/bootstrap.bundle.min.js"></script>
    <script src="js/index.js"></script>
</body>

</html>