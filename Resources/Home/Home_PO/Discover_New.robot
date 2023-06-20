***Settings***
Library                                   SeleniumLibrary
Resource                                  ../../Local_Keywords.robot

***Keywords***
Discover New Section Validation
    Scroll To                                       xpath=//div[contains(@class,'j-grid discover-cards-wrapper')] 
    #Title Verification
    Text Verification                               xpath=//h2[@class="j-contentBlock__title j-heading j-text-heading-l" and contains(text(),'Discover')]       Discover new possibilities
    CSS Verification                                xpath=//h2[@class="j-contentBlock__title j-heading j-text-heading-l" and contains(text(),'Discover')]       font-weight     900
   
    #SubText Verification
    Text Verification                               xpath=//div[contains(@class,"j-contentBlock__description") and contains(text(),'Planning')]        Planning a digital transformation for home, business, or personal experiences? You're just a step away.
    
    #Icons Verifications
    ${DNP_Icons}=    Get WebElements                 xpath=//div[@class='custom_icon_size size_icon_home m-auto flex-shrink-0']
    ${DNP_Icons_Length}=     Get Length      ${DNP_Icons}
    Log To Console    ${DNP_Icons_Length}
    FOR  ${Icon_Verification}    IN  @{DNP_Icons}
        Wait For And Verify Element                 ${Icon_Verification}
    END
    
    #Title Verifications
    ${Inc}  Set Variable   0
    ${DNP_Titles}=    Get WebElements                 xpath=//div[@class='j-grid']//h3
    ${DNP_Titles_Length}=     Get Length      ${DNP_Titles}
    Log To Console    ${DNP_Titles_Length}
    FOR  ${DNP_Title}    IN  @{DNP_Titles}
        Text Verification   ${DNP_Title}                ${Discovernew_iconname}[${Inc}]
        CSS Verification    ${DNP_Title}              font-weight     900
        ${inc}=   Evaluate     ${inc} + 1  
    END

    #Sub text verification
    ${Inc}  Set Variable   0
    ${DNP_SubTexts}=    Get WebElements                     xpath=//div[@class="j-color-primary-grey-80 j-contentBlock__description j-text-body-s"]
    ${DNP_SubTexts_Length} =     Get Length      ${DNP_SubTexts}
    Log To Console    ${DNP_SubTexts_Length}
    FOR  ${DNP_SubText}    IN  @{DNP_SubTexts}
        Text Verification                        ${DNP_SubText}     ${Discovernew_subtext}[ ${Inc}]
         ${Inc}=   Evaluate      ${Inc} + 1  
    END

    #Icon button redirection
    ${Button_Redirection}  Set Variable   0
    WHILE  ${Button_Redirection} < 3
        Redirection On Clicking                      xpath=//button[@aria-label="${Discovernew_buttons}[${Button_Redirection}]"]   ${Discovernew_urls}[${Button_Redirection}]      DNP_${Discovernew_iconname}[${Button_Redirection}]
        CSS Verification                             xpath=//button[@aria-label="${Discovernew_buttons}[${Button_Redirection}]"]     font-weight     700
        ${Button_Redirection}=   Evaluate     ${Button_Redirection} + 1
    END
