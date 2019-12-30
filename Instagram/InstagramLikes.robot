*** Settings ***
Library    Selenium2Library
Library    BuiltIn

*** Variables ***
${Locator_PictureCards}    //div[@class="_9AhH0"]
${Locator_HeartButton}    //span[@class="fr66n"]/button[@class="dCJp8 afkep"]
${Locator_NextArrow}    //a[contains(@class,"RightPaginationArrow")]
${Locator_CloseButton}    //button[.="Close"]

*** Test Cases ***
Instagram Likes
    Open Browser    https://www.instagram.com/coleen/    chrome
    Maximize Browser Window
    Set Suite Variable    ${TotalHeartsForPictures}    0
    Set Suite Variable    ${TotalAccountsLiked}    0
    Set Suite Variable    ${ScrollHeight}    100
    Wait Until Element Is Visible    //button[text()="Log In"]    20s
    Click Element    //button[text()="Log In"]
    Wait Until Element Is Visible    //input[@name="username"]    20s
    Input Text    //input[@name="username"]    sampleuser
    Input Text    //input[@name="password"]    samplepass
    Click Element    //div[text()="Log In"]
    Wait Until Element Is Visible    //a[contains(@href,'followers')]    20s
    Click Element    //a[contains(@href,'followers')]
    Wait Until Page Contains Element    //div[@class="PZuss"]/li    20s
    Comment    ${Count}    Get Element Count    //div[@class="PZuss"]/li
    :FOR    ${Index}    IN RANGE    1    20
    \    Scroll Until Element Is Visible    //div[@class="PZuss"]/li[${Index}]/div//div[2]/div[1]
    \    ${Title}    Get Text    //div[@class="PZuss"]/li[${Index}]/div//div[2]/div[1]
    \    Wait Until Element Is Visible    //div[@class="PZuss"]/li[${Index}]/div//div[2]/div[1]    20s
    \    Click Element    //div[@class="PZuss"]/li[${Index}]//div[2]/div[1]//a
    \    Wait Until Page Contains    ${Title}    20s
    \    ${Element}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Locator_PictureCards}    1s
    \    Run Keyword If    ${Element}==True    Click Picture Card
    \    Run Keyword If    ${Element}==False    Go Back
    Log    Total Hearts Given To Pictures = ${TotalHeartsForPictures}
    Log    Total Accounts Liked = ${TotalAccountsLiked}
    Close Browser

*** Keywords ***
Click Picture Card
    ${NumberOfPictures}    Get Element Count    ${Locator_PictureCards}
    Click Element    ${Locator_PictureCards}
    Run Keyword If    ${NumberOfPictures}==1    Click Heart 1 Time
    Run Keyword If    ${NumberOfPictures}==2    Click Hearts 2 Times
    Run Keyword If    ${NumberOfPictures}==3    Click Hearts 3 Times
    Run Keyword If    ${NumberOfPictures}>3    Click Hearts More Than 3

Click Heart 1 Time
    Wait Until Element Is Visible    ${Locator_HeartButton}    20s
    Click Element    ${Locator_HeartButton}
    Go Back
    Go Back
    ${TotalHeartsForPictures}    Evaluate    ${TotalHeartsForPictures}+1
    Set Suite Variable    ${TotalHeartsForPictures}    ${TotalHeartsForPictures}
    ${TotalAccountsLiked}    Evaluate    ${TotalAccountsLiked}+1
    Set Suite Variable    ${TotalAccountsLiked}    ${TotalAccountsLiked}

Click Hearts 2 Times
    FOR    ${Index}    IN RANGE    1    2
    \    Wait Until Element Is Visible    ${Locator_HeartButton}    20s
    \    Click Element    ${Locator_HeartButton}
    \    ${ArrowButton}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Locator_NextArrow}    1s
    \    Run Keyword If    ${ArrowButton}==True    Click Element    ${Locator_NextArrow}
    Go Back
    Go Back
    Go Back
    ${TotalHeartsForPictures}    Evaluate    ${TotalHeartsForPictures}+2
    Set Suite Variable    ${TotalHeartsForPictures}    ${TotalHeartsForPictures}
    ${TotalAccountsLiked}    Evaluate    ${TotalAccountsLiked}+1
    Set Suite Variable    ${TotalAccountsLiked}    ${TotalAccountsLiked}

Click Hearts 3 Times
    FOR    ${Index}    IN RANGE    1    4
    \    Wait Until Element Is Visible    ${Locator_HeartButton}    20s
    \    Click Element    ${Locator_HeartButton}
    \    ${ArrowButton}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Locator_NextArrow}    1s
    \    Run Keyword If    ${ArrowButton}==True    Click Element    ${Locator_NextArrow}
    Go Back
    Go Back
    Go Back
    Go Back
    ${TotalHeartsForPictures}    Evaluate    ${TotalHeartsForPictures}+3
    Set Suite Variable    ${TotalHeartsForPictures}    ${TotalHeartsForPictures}
    ${TotalAccountsLiked}    Evaluate    ${TotalAccountsLiked}+1
    Set Suite Variable    ${TotalAccountsLiked}    ${TotalAccountsLiked}

Click Hearts More Than 3
    FOR    ${Index}    IN RANGE    1    4
    \    Wait Until Element Is Visible    ${Locator_HeartButton}    20s
    \    Click Element    ${Locator_HeartButton}
    \    ${ArrowButton}    Run Keyword And Return Status    Wait Until Element Is Visible    ${Locator_NextArrow}    1s
    \    Run Keyword If    ${ArrowButton}==True    Click Element    ${Locator_NextArrow}
    Go Back
    Go Back
    Go Back
    Go Back
    Go Back
    ${TotalHeartsForPictures}    Evaluate    ${TotalHeartsForPictures}+3
    Set Suite Variable    ${TotalHeartsForPictures}    ${TotalHeartsForPictures}
    ${TotalAccountsLiked}    Evaluate    ${TotalAccountsLiked}+1
    Set Suite Variable    ${TotalAccountsLiked}    ${TotalAccountsLiked}

Scroll Until Element Is Visible
    [Arguments]    ${Locator}
    FOR    ${Index}    IN RANGE    0    5
    \    ${Status}=    Run Keyword And Return Status    Page Should Contain Element    ${Locator}
    \    Run Keyword If    ${Status}==False    Scroll Down
    \    Run Keyword If    ${Status}==True    Exit For Loop

Scroll Down
    Execute Javascript    document.querySelector('div.isgrP').scrollTop = ${ScrollHeight}
    ${ScrollHeight}=    Evaluate    ${ScrollHeight}+100
    Set Suite Variable    ${ScrollHeight}    ${ScrollHeight}
