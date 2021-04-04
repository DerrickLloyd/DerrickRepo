*** Settings ***
Library    sendmail.SendEmailUtility
Library    Selenium2Library
Library    BuiltIn
Library    DateTime
Library    Collections
Library    String

*** Variables ***
@{chrome_arguments}    --disable-infobars    --headless    --disable-gpu

*** Test Cases ***
Shopee Live
    ${chrome_options}=    Set Chrome Options
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Go To    https://live.shopee.ph/p/live-end?type=guest&room_id=478743&session=1430560&shop_id=11236840&host_user_id=11238140&product_total_count=474&current_member_count=3694&follow_status=0&can_show_items&bgurl=28c293d4e2300981bf70174f822c8277&host_avatar=a0b6c48c9186b5eebe7aa7aa8838f8a8&host_name=louxx&session_title=First%20Ever%20Stream%20for%202021!!%20Happy%20January%20Shopee%20Fam!!%20%F0%9F%8E%86%F0%9F%A7%A1#from_source=share
    ${Date}=    Set Variable    Test
    #Open Browser    https://live.shopee.ph/p/live-end?type=guest&room_id=478743&session=1430560&shop_id=11236840&host_user_id=11238140&product_total_count=474&current_member_count=3694&follow_status=0&can_show_items&bgurl=28c293d4e2300981bf70174f822c8277&host_avatar=a0b6c48c9186b5eebe7aa7aa8838f8a8&host_name=louxx&session_title=First%20Ever%20Stream%20for%202021!!%20Happy%20January%20Shopee%20Fam!!%20%F0%9F%8E%86%F0%9F%A7%A1#from_source=share    chrome
    #Set Selenium Speed    0.2
    #Maximize Browser Window
    @{ShopeeShopsList}=    Create List    ${EMPTY}
    FOR    ${Index}    IN RANGE    1    99999
    \    Wait Until Element Is Visible    //div[contains(@class, 'card-current section-card')]    20s
    \    execute javascript    window.scrollTo(0,document.body.scrollHeight);
    \    #Sleep    0.5s
    \    execute javascript    window.scrollTo(0,document.body.scrollHeight);
    \    #Sleep    0.5s
    \    execute javascript    window.scrollTo(0,document.body.scrollHeight);
    \    #Sleep    0.5s
    \    execute javascript    window.scrollTo(0,document.body.scrollHeight);
    \    #Sleep    0.5s
    \    ${NumberofShopeeCoins}=    Get Element Count    //div[contains(@class, 'CoinsIcon-card-coins-count')]
    \    Check Shopee Coins    ${NumberofShopeeCoins}    @{ShopeeShopsList}
    \    @{ShopeeShopsList}=    Run Keyword If    ${Index}%90==0    Create List    ${EMPTY}
    \    Get Current Time In AM PM
    \    Run Keyword If    '${Date}'=='12:09 AM'    Pass Execution    Thank you for using Shopee Live Coin Checker Automation! Have a Great Day Ahead! :)        
    \    #Sleep    1s
    \    Reload Page
    Close Browser

*** Keywords ***
Check Shopee Coins
    [Arguments]    ${NumberofShopeeCoins}    @{ShopeeShopsList}
    FOR    ${index}    IN RANGE    1    ${NumberofShopeeCoins}+1
    \    ${ShopeeCoins}=    Get Text    xpath=(//div[contains(@class, 'CoinsIcon-card-coins-count')])[${index}]
    \    ${ShopeeShop}=    Get Text    xpath=(//div[contains(@class, 'CoinsIcon-card-coins-count')])[${index}]/ancestor::div/following-sibling::div[contains(@class,'current-live-card-info-wrap')]//span
    \    ${ShopeeShop}=    Replace String Using Regexp    ${ShopeeShop}    [^A-Za-z0-9 _@./,'#&+-]    ${EMPTY}
    \    Log List    ${ShopeeShopsList}
    \    #Run Keyword If    "${ShopeeCoins}"=="+0.1"    Send Results With Exact Link    ${index}    ${ShopeeShop}    0.1    @{ShopeeShopsList}   
    \    #Run Keyword If    "${ShopeeCoins}"=="+0.2"    Send Results With Exact Link    ${index}    ${ShopeeShop}    0.2    @{ShopeeShopsList}
    \    #Run Keyword If    "${ShopeeCoins}"=="+0.3"    Send Results With Exact Link    ${index}    ${ShopeeShop}    0.3    @{ShopeeShopsList}
    \    #Run Keyword If    "${ShopeeCoins}"=="+0.5"    Send Results With Exact Link    ${index}    ${ShopeeShop}    0.5    @{ShopeeShopsList}
    \    #Run Keyword If    "${ShopeeCoins}"=="+1"    Send Results With Exact Link    ${index}    ${ShopeeShop}    1    @{ShopeeShopsList}
    \    #Run Keyword If    "${ShopeeCoins}"!="+0.1" and "${ShopeeCoins}"!="+0.2"    Send Results With Exact Link    ${index}    ${ShopeeShop}    ${ShopeeCoins}    @{ShopeeShopsList}
    \    #------ Send Results Without Exact URL Link Below -------
    \    #Run Keyword If    "${ShopeeCoins}"=="+0.1"    Send Results Without The Exact Link    ${index}    ${ShopeeShop}    0.1    @{ShopeeShopsList}   
    \    #Run Keyword If    "${ShopeeCoins}"=="+0.2"    Send Results Without The Exact Link    ${index}    ${ShopeeShop}    0.2    @{ShopeeShopsList}
    \    #Run Keyword If    "${ShopeeCoins}"=="+0.3"    Send Results Without The Exact Link    ${index}    ${ShopeeShop}    0.3    @{ShopeeShopsList}
    \    Run Keyword If    "${ShopeeCoins}"=="+0.5"    Send Results Without The Exact Link    ${index}    ${ShopeeShop}    0.5    @{ShopeeShopsList}
    \    Run Keyword If    "${ShopeeCoins}"=="+1"    Send Results Without The Exact Link    ${index}    ${ShopeeShop}    1    @{ShopeeShopsList}
    \    Run Keyword If    "${ShopeeCoins}"!="+0.1" and "${ShopeeCoins}"!="+0.2"    Send Results Without The Exact Link    ${index}    ${ShopeeShop}    ${ShopeeCoins}    @{ShopeeShopsList}

Send Results With Exact Link
    [Arguments]    ${index}    ${ShopeeShop}    ${NumberOfCoins}    @{ShopeeShopsList}
    ${URL}=    Set Variable    Test
    ${Date}=    Set Variable    Test
    FOR    ${ShopeeShops}    IN    @{ShopeeShopsList}
    \    Run Keyword If    $ShopeeShop in $ShopeeShopsList    Exit For Loop    ELSE    Run Keywords    Append To List    ${ShopeeShopsList}    ${ShopeeShop}    AND    Click Element At Coordinates    (//div[contains(@class, 'CoinsIcon-card-coins-count')])[${index}]/ancestor::div/following-sibling::div[contains(@class,'current-live-card-info-wrap')]//div[contains(@class,'card-profile')]    10    10    AND    Get URL    AND    Get Current Time In AM PM    AND    Log Results And Send Email    ${Date}    ${URL}    ${ShopeeShop}    ${NumberOfCoins}    AND    Close New Tab And Go Back To Previous Tab
    @{ShopeeShopsList}=    Set Suite Variable    ${ShopeeShopsList}

Send Results Without The Exact Link
    [Arguments]    ${index}    ${ShopeeShop}    ${NumberOfCoins}    @{ShopeeShopsList}
    ${Date}=    Set Variable    Test
    FOR    ${ShopeeShops}    IN    @{ShopeeShopsList}
    \    Run Keyword If    $ShopeeShop in $ShopeeShopsList    Exit For Loop    ELSE    Run Keywords    Append To List    ${ShopeeShopsList}    ${ShopeeShop}    AND    Get Current Time In AM PM    AND    Log Results And Send Email    ${Date}    ${ShopeeShop}    ${ShopeeShop}    ${NumberOfCoins}
    @{ShopeeShopsList}=    Set Suite Variable    ${ShopeeShopsList}

Log Results And Send Email
    [Arguments]    ${Date}    ${URL}    ${ShopeeShop}    ${NumberOfCoins}
    Log to console    ${Date} ${URL} has ${NumberOfCoins} coins (${ShopeeShop})
    Run Keyword And Continue On Failure    Send Email    ${Date} ${URL} has ${NumberOfCoins} coins (${ShopeeShop})    danapua@gmail.com
    Run Keyword And Continue On Failure    Send Email    ${Date} ${URL} has ${NumberOfCoins} coins (${ShopeeShop})    pua_derrick@yahoo.com
    Run Keyword And Continue On Failure    Send Email    ${Date} ${URL} has ${NumberOfCoins} coins (${ShopeeShop})    derrick.pua@adventureconsultancysolutions.com
    
Send Email
    [Arguments]    ${ShopeeMessage}    ${Email}
    Send Mail No Attachment    derrickshopeetest@gmail.com    shopeecoins123    ${Email}    ${ShopeeMessage}    ${ShopeeMessage}
    
Get URL
    Sleep    3s
    ${title_var}        Get Window Titles
    Switch Window       title=@{title_var}[1]
    ${URL}=    Get Location
    Set Suite Variable    ${URL}    ${URL}

Close New Tab And Go Back To Previous Tab
    Sleep    3s
    ${title_var}        Get Window Titles
    Switch Window       title=@{title_var}[1]       
    Close Window
    Switch Window       title=@{title_var}[0]

Get Current Time In AM PM
    ${Date}=    Get Current Date
    ${Date}=    Convert Date    ${Date}    result_format=%I:%M %p
    Set Suite Variable    ${Date}    ${Date}
    
Set Chrome Options
    [Documentation]    Set Chrome options for headless mode
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    FOR    ${option}    IN    @{chrome_arguments}
    \    Call Method    ${options}    add_argument    ${option}
    [Return]    ${options}