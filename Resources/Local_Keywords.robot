*** Settings ***
Library                             SeleniumLibrary
Library                             ExcelLibrary
Library                             Dialogs
Library                             RequestsLibrary
Library                             String
Library                             Collections
Resource                            ../Resources/Common.robot
Resource                            Excel_Activity.robot
Variables                           Common_Variables.yaml
Variables                           ../Tests/Shop/AddtoCart_Variables.yaml                        
Variables                           ../Tests/Support/LocateUs_Variables.yaml
Variables                           ../Tests/Mobile/MDiscover_Variable.yaml
Variables                           Tester_Input.yaml

*** Keywords ***

#-------------------------------------------------------------------- Home Page Local_Keywords -----------------------------------------------------------------------------#
Pop-Up Verification Home
    [Arguments]      ${Title}
    #Close Button
    Wait For And Verify Element               xpath=//button[contains(@onclick,'close')]
    #Rupees Symbol
    Wait For And Verify Element               xpath=//div[@class='input-info-wrapper']//span[@class='j-icon j-icon__bg']//*[name()='svg']
    #Toggle Button
    Wait For And Verify Element               xpath=//div[contains(@class,'jds-tabs jds-tabs-filled jds-tabs-radius jds-tabs-icon modal-jds-tabs')]
    #Onkar.Sarje
    IF  "${Title}" == "Quick Recharge"
        CSS Verification                      xpath=//h5[normalize-space()='Quick Recharge']	    font-weight	     900
        ${Status}=         Run Keyword And Return Status   Wait For And Verify Element       xpath=//a[@aria-controls="mobile"][@aria-selected="true"]
        #Mobile & Fiber Tab
        IF  ${Status} == True
        #Quick Recharge sub-title
            Text Verification                  xpath=//div[@class='j-contentBlock__description j-text-body-xs j-color-primary-grey-80']  Enter your Jio number
            #Enter Mobile Number
            Text Verification                  xpath=//label[@class='field-label' and @for='type-id-1' and contains(text(),'Mobile')]  Mobile Number
            Wait For And Click Element         xpath=//a[@aria-controls="fiber"][@aria-selected="false"]
            Text Verification                  xpath=//div[@class='j-contentBlock__description j-text-body-xs j-color-primary-grey-80']  Enter your JioFiber number
            #Enter JioFiber Number
            Text Verification                  xpath=//label[@class='field-label' and @for='type-id-1' and contains(text(),'JioFiber')]  JioFiber Number
            #i button
            Wait For And Click Element         xpath=//span[@data-popup-open='modal-info']
            #i button popup UI Verification
            Wait For And Verify Element        xpath=//div[@class="j-modal-container"]//button[@data-popup-close="modal-info"]
            Wait For And Verify Element        xpath=//div[@class="j-text-heading-xs"]
            Wait For And Verify Element        xpath=//div[@class="j-text-body-xxs "]
            #i button popup Text Verification
            Text Verification                  xpath=//div[@class="j-modal-container"]//button[@data-popup-close="modal-info"]    ${iButton}[0]
            Text Verification                  xpath=//div[@class="j-text-heading-xs"]    ${iButton}[1]
            Text Verification                  xpath=//div[contains(text(),'You may enter any of the following details:')]    ${iButton}[2]
            #i button     popup Text Verification subtext
            Text Verification                  xpath=//ul[@class="pd--left m-0"]//li[1]    ${iButton}[3]
            Text Verification                  xpath=//ul[@class="pd--left m-0"]//li[2]    ${iButton}[4]
            Text Verification                  xpath=//ul[@class="pd--left m-0"]//li[3]    ${iButton}[5]
            #Back button
            Wait For And Click Element         xpath=//div[@class="j-modal-container"]//button[@data-popup-close="modal-info"]
            Wait For And Click Element         xpath=//a[@aria-controls="mobile"][@aria-selected="false"]
        END 
    ELSE IF  "${Title}" == "Pay Bill"
        CSS Verification                       xpath=//h5[normalize-space()='Pay Bill']	    font-weight	     900
        ${Status}=         Run Keyword And Return Status   Wait For And Verify Element     xpath=//a[@aria-controls="mobile1"][@aria-selected="true"]
        #Mobile & Fiber Tab
        IF  ${Status} == True
            #Quick Recharge sub-title
            Text Verification                   xpath=//div[@class="j-contentBlock__content"]//div[contains(normalize-space(),"Paying bills")]  Paying bills was never this easy
            #Enter Mobile Number
            Text Verification                   xpath=//label[@class='field-label' and @for='type-id-1' and contains(text(),'Mobile')]  Postpaid Mobile Number            
            Wait For And Click Element          xpath=//a[@aria-controls="fiber1"][@aria-selected="false"]
            #Enter JioFiber Number
            Text Verification                   xpath=//label[@class='field-label' and @for='type-id-1' and contains(text(),'JioFiber')]  Postpaid JioFiber Number
            #i button
            Wait For And Verify Element        xpath=//span[@data-popup-open='modal-pb-info']
        END
        #Rupaye symbol in Amount field  
        Wait For And Verify Element            xpath=//span[@class="input-icon input-icon-prefix clickable"]
        #Enter Amount
        Text Verification                      xpath=//label[@class='field-label' and contains(text(),'Am')]  Amount
        Wait For And Click Element             xpath=//a[@aria-controls="mobile1"][@aria-selected="false"]
        #Please Note Text Verification
        Text Verification                      xpath=//div[@class="j-text j-text-body-xxs j-color-primary-grey-80"]    ${PleaseNote}  
    ELSE 
        Log  Random Popup
    END
    #Continue,View Bill Summary button
    ${buttons}=     Get WebElements            xpath=//button[contains(@class,'btn-disabled')]
    ${buttons_length}=    Get Length        ${buttons}
    Log To Console        ${buttons_length}
    FOR  ${button}  IN  @{buttons}
        Button Verification                    ${button}
    END
Check Buttons Enabled
    [Arguments]     ${name_locator}     ${name}   ${number_locator}     ${number}   ${Bt_locator}  
    # Site Change Button is by Default Enabled.    
    # Element Should Be Disabled          ${Bt_locator}
    Wait For And Click Element          ${name_locator}
    Wait For And Input Text             ${name_locator}         ${name}
    Sleep   200ms
    Wait For And Click Element          ${number_locator}
    Wait For And Input Text             ${number_locator}       ${number}
    Sleep   200ms
    Element Should Be Enabled           ${Bt_locator}

Paybill Mobile Tab Validation
    [Arguments]         ${Number}
    #Check Cross Button is not visible
    Wait Until Element Is Not Visible   xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Wait Until Element Is Not Visible   xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
   
    #Blank Enteries Toast Verification for Mobile Page
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][1]
    Text Verification                   xpath=//*[@id="gen-paybill-user-number-invalid"]/div/span    Please enter a valid Jio number
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][2]   
    Text Verification                   xpath=//*[@id="gen-paybill-user-number-invalid"]/div/span    Please enter a valid Jio number
    Text Verification                   xpath=//*[@id="gen-paybill-user-amount-invalid"]/div/span    Please enter a valid bill amount       
   
    #Toast Verfication of Mobile Tab
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        1234567890
    Wait For And Click Element          xpath=//button[normalize-space()='View bill summary']
    Text Verification                   xpath=//*[@id="dyn-sendotp-paybill-geninvalid"]/div/span   Please enter a valid Jio number/Service ID
    Wait For And Click Element          xpath=//button[@onclick='payBillContinueWithAmt(this)']
    Text Verification                   xpath=//*[@id="gen-paybill-user-amount-invalid"]/div/span    Please enter a valid bill amount       
   
    #Clear Textfield
    #Cross Button Functionality of Mobile Tab
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        ${Number}                                                                
    Wait For And Input Text             xpath=//input[@id='paybill-user-amount']        100
    Sleep    200ms 
    Cross Button Functionality          xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Cross Button Functionality          xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    
    #Prepaid Number Verification Mobile Tab
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        ${Number}                                                                
    Wait For And Input Text             xpath=//input[@id='paybill-user-amount']        100 
    Cross Button Functionality          xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Cross Button Functionality          xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        ${Number}                                                                
    Wait For And Input Text             xpath=//input[@id='paybill-user-amount']        100 
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][2] 
    Text Verification                   xpath= //div[@id='dyn-submitamt-paybill-geninvalid']//div[@class='field-error']    Invalid Request
    Sleep    3s

Paybill Fiber Tab Validation 
   [Arguments]         ${Number}  
    #Check Cross Button is not visible
    Wait Until Element Is Not Visible   xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Wait Until Element Is Not Visible   xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    
    #i button
    Wait For And Click Element         xpath=//span[@data-popup-open='modal-pb-info']
    #i button popup UI Verification
    Wait For And Verify Element        xpath=//div[@class="j-modal-container"]//button[@data-popup-close="modal-pb-info"]
    Wait For And Verify Element        xpath=//div[@class="j-text-heading-xs"]
    Wait For And Verify Element        xpath=//div[@class="j-text-body-xxs "]
    #i button popup Text Verification
    Text Verification                  xpath=//div[@class="j-modal-container"]//button[@data-popup-close="modal-pb-info"]    ${iButton}[0]
    Text Verification                  xpath=//div[@class="j-text-heading-xs"]    ${iButton}[1]
    Text Verification                  xpath=//div[contains(text(),'You may enter any of the following details:')]    ${iButton}[2]
    #i button popup Text Verification subtext
    #Text Verification                  xpath=//ul[@class="pd--left m-0"]//li[1]    ${iButton}[3]
    Text Verification                  xpath=//ul[@class="pd--left m-0"]//li[1]    ${iButton}[4]
    Text Verification                  xpath=//ul[@class="pd--left m-0"]//li[2]    ${iButton}[5]
    #Back button
    Click Element                      xpath=//div[@class="j-modal-container"]//button[@data-popup-close="modal-pb-info"]
    
    #Blank Enteries Toast Verification for Fiber Page
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][1]
    Text Verification                   xpath=//*[@id="gen-paybill-user-number-invalid"]/div/span    Please enter a valid JioFiber number
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][2]     
    Text Verification                   xpath=//*[@id="gen-paybill-user-amount-invalid"]/div/span    Please enter a valid bill amount       
    
    #Invalid Number Text Verification
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        1234567890
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][1]
    Text Verification                   xpath=//div[@id='dyn-sendotp-paybill-geninvalid']    Please enter a valid Jio number/Service ID
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][2]   
    Text Verification                   xpath=//div[@id='gen-paybill-user-amount-invalid']//div[contains(@class,'field-error')]    Please enter a valid bill amount
    
    #Clear Textfield
    #Cross Button Functionality of Fiber Tab
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        ${Number}                                                                
    Wait For And Input Text             xpath=//input[@id='paybill-user-amount']        100 
    Cross Button Functionality          xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Cross Button Functionality          xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    
    #Prepaid Number Verification Fiber Tab
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        ${Number}                                                                
    Wait For And Input Text             xpath=//input[@id='paybill-user-amount']        100 
    Cross Button Functionality          xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Cross Button Functionality          xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        ${Number}                                                                
    Wait For And Input Text             xpath=//input[@id='paybill-user-amount']        100 
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][2] 
    Text Verification                   xpath=//div[@id='dyn-submitamt-paybill-geninvalid']//div[@class='field-error']    Invalid Request

Check Continue Button Enabled
    [Arguments]     ${text_locator}     ${locator}      ${text}
    Element Should Be Disabled      ${locator}
    Wait For And Click Element      ${text_locator}
    Sleep   200ms
    Wait For And Input Text         ${text_locator}     ${text}
    Sleep   200ms
    Element Should Be Enabled       ${locator}

Need Guidance Section Validation                                            
   Scroll To                              xpath=//section[@class="j-container bg--primary-background"]
   Wait For And Verify Element               xpath=//section[@class="j-container bg--primary-background"]
   Take Element Screenshot                   xpath=//section[@class="j-container bg--primary-background"]            NeedGuidance
   ${Inc}    Set Variable    0
   # Need Guidance Text Verification
   Text verification             xpath=//section[@class="j-container bg--primary-background"]//h2[@class="j-contentBlock__title j-heading j-text-heading-l"]                      Need guidance?
   # Need Guidance CSS Verification
   CSS Verification            xpath=//section[@class="j-container bg--primary-background"]//h2[@class="j-contentBlock__title j-heading j-text-heading-l"]    font-weight    900
   #We’d love to help you. Text Verification
   Text verification             xpath=//section[@class="j-container bg--primary-background"]//div[@class="j-contentBlock__description j-text-body-m j-color-primary-grey-80"]    We’d love to help you.
   #Support Button Text Verification
   ${Buttons}=      Get WebElements      xpath=//button[@class="j-button j-button-size__medium secondary icon-primary icon-primary-inline j-button-flex "] 
   FOR  ${Button}  IN  @{Buttons}
      Text verification    ${Button}   ${Button_Name}[${Inc}]
      ${Inc}=   Evaluate       ${Inc} + 1   
   END
                            

   #Support Button Redirection Check
   ${VB}  Set Variable   0
   WHILE  ${VB} < 4
      Redirection On Clicking     xpath=//button[@class="j-button j-button-size__medium secondary icon-primary icon-primary-inline j-button-flex "]//div[contains(text(),'${Button_Name}[${VB}]')]   ${Guidance_UrlList}[${VB}]    ${Button_Name}[${VB}]  
      ${VB}=   Evaluate     ${VB} + 1
   END

Banner Redirection with content verification
    [Arguments]        ${Sc_Name}
    ${visiblity}=   Run Keyword And Return Status   Wait Until Element Is Visible       xpath=//ul[@class='slick-dots']
    ${RURL}=    Get Location
    IF  ${visiblity} == True
        ${VB}  Set Variable   0
        WHILE  ${VB} < 2
            Wait For And Click Element      xpath=//li[${VB}+1]//button[1]
            Sleep  300ms
            Text Verification               xpath=(//h2[@class="j-color-primary-grey-100 j-text-heading-l"])[${VB}+1]   ${Banner_title}[${VB}]
            CSS Verification 	            xpath=(//h2[@class="j-color-primary-grey-100 j-text-heading-l"])[${VB}+1]    font-weight	 900
            Wait For And Click Element      xpath=(//button[@class="j-button j-button-size__medium primary redirectButton w-auto mr-3 mt-3 "])[${VB}+1]
            Take Page Screenshot            ${Sc_Name}_BannerRedirection_${VB}
            Log To Console                  ${Sc_Name}_Banner_${VB} Redirection Successful
            Go To                           ${RURL}
            ${VB}=   Evaluate     ${VB} + 1
        END

        Wait For And Click Element      xpath=//li[3]//button[1]
        Sleep  300ms
        Text Verification               xpath=//h2[normalize-space()='Ad-free music, unlimited connectivity!']   ${Banner_title}[2]
        CSS Verification 	            xpath=//h2[normalize-space()='Ad-free music, unlimited connectivity!']    font-weight	 900
        Wait For And Click Element      xpath=(//button[@class="j-button j-button-size__medium primary redirectButton w-auto mr-3 mt-3 "])[3]
        Take Page Screenshot            ${Sc_Name}_BannerRedirection_[3]
        Log To Console                  ${Sc_Name}_Banner_[3] Redirection Successful
        Go To                           ${RURL}
    ELSE
        Wait For And Click Element        xpath=//li[${VB}]//button[1]      
        Take Page Screenshot                 ${Sc_Name}_BannerRedirection
        Log To Console                  ${Sc_Name}_Banner_Redirection Successful
        Go Back
    END

#---------------------------------------------------- Mobile and Fiber ----------------------------------------------

Pop-Up Verification
    [Arguments]      ${Title}
    # Cross Button
    Wait For And Verify Element             xpath=//button[contains(@onclick,'close')]
    # Rupees Symbol
    Wait For And Verify Element             xpath=//div[@class='input-info-wrapper']//span[@class='j-icon j-icon__bg']//*[name()='svg']
    # Toggle Button
    Wait For And Verify Element             xpath=//div[contains(@class,'jds-tabs jds-tabs-filled jds-tabs-radius jds-tabs-icon modal-jds-tabs')]
    # Checking title 'Quick recharge'
    IF  "${Title}" == "Quick Recharge"
        
        # Getting status whether Mobile tab is selected by default.
        ${Status}=         Run Keyword And Return Status   Wait For And Verify Element     xpath=//a[@aria-controls="mobile"][@aria-selected="true"]

        # Checking status whether tab is active.
        IF  ${Status} == True
            
            # Quick Recharge sub-title
            Text Verification                xpath=//div[@class='j-contentBlock__description j-text-body-xs j-color-primary-grey-80']       Enter your Jio number
            
            # Mobile Number Placeholder verification
            Text Verification                xpath=//label[@class='field-label' and @for='type-id-1' and contains(text(),'Mobile')]         Mobile Number
            
            # Clicking on fiber tab
            Wait For And Click Element       xpath=//a[@aria-controls="fiber"][@aria-selected="false"]
            
            # Quick Recharge sub-title
            Text Verification                xpath=//div[@class='j-contentBlock__description j-text-body-xs j-color-primary-grey-80']       Enter your JioFiber number
            
            # JioFiber Number Placeholder verification
            Text Verification                xpath=//label[@class='field-label' and @for='type-id-1' and contains(text(),'JioFiber')]       JioFiber Number
            
            # Input Box 'i' button verification
            Wait For And Verify Element     xpath=//span[@data-popup-open='modal-info']
            
            # Clicking on Mobile tab
            Wait For And Click Element       xpath=//a[@aria-controls="mobile"][@aria-selected="false"]
        END

    ELSE IF  "${Title}" == "Pay Bill"

        # Getting status whether Mobile tab is selected by default.
        ${Status}=         Run Keyword And Return Status   Wait For And Verify Element     xpath=//a[@aria-controls="mobile1"][@aria-selected="true"]
        
        IF  ${Status} == True

            # Quick Recharge sub-title
            Text Verification                xpath=//div[@class="j-contentBlock__content"]//div[contains(normalize-space(),"Paying bills")]     Paying bills was never this easy
           
            # Placeholder verification
            Text Verification                xpath=//label[@class='field-label' and @for='type-id-1' and contains(text(),'Mobile')]     Postpaid Mobile Number            
            
            # Clicking on fiber tab
            Wait For And Click Element       xpath=//a[@aria-controls="fiber1"][@aria-selected="false"]
            
            # Placeholder Verification
            Text Verification                xpath=//label[@class='field-label' and @for='type-id-1' and contains(text(),'JioFiber')]       Postpaid JioFiber Number
            
            # Input Box 'i' button verification
            Wait For And Verify Element     xpath=//span[@data-popup-open='modal-pb-info']
        END
        # Rupee symbol in Amount field  
        Wait For And Verify Element         xpath=//span[@class="input-icon input-icon-prefix clickable"]
        
        # Placeholder Text Verification
        Text Verification                   xpath=//label[@class='field-label' and contains(text(),'Am')]  Amount

        # Clicking on Mobile tab
        Wait For And Click Element          xpath=//a[@aria-controls="mobile1"][@aria-selected="false"]
    ELSE 
        Log  Random Popup
    END

    #Continue,View Bill Summary button Verification
    ${buttons}=     Get WebElements     xpath=//button[contains(@class,'btn-disabled')]
    FOR  ${button}  IN  @{buttons}
        Button Verification         ${button}
    END

Paybill Tab Validation-Mobile
    [Arguments]         ${Number}
    
    # Checking First Clear Button is not visible
    Wait Until Element Is Not Visible   xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']

    # Checking Second Clear Button is not visible
    Wait Until Element Is Not Visible   xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    
    # Check Continue Button Enabled or not
    Run Keyword And Continue On Failure    Check Continue Button Enabled                xpath=//input[@id='paybill-user-number']                xpath=//button[contains(@class,'btn-disabled')][1]        ${Incorrect_No1}
        
    # Invalid Number Verification
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][1]
    
    # Verifying the error text appear
    Text Verification                   xpath=//div[@id='dyn-sendotp-paybill-geninvalid']                  Please enter a valid Jio number/Service ID  
    
    # Clear Textfield
    Cross Button Functionality          xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    
    #Prepaid Number Verification
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        ${Number} 
    Wait For And Input Text             xpath=//input[@id='paybill-user-amount']        100 
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][2] 
    Text Verification                   xpath=//div[@id='dyn-submitamt-paybill-geninvalid']    You are subscribed to a corporate plan. Payments are not allowed for this plan     

Paybill Tab Validation-Fiber
    [Arguments]         ${Number}
    #Check Cross Button is not visible
    Wait Until Element Is Not Visible   xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    Wait Until Element Is Not Visible   xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    
    #Check Continue Button Enabled or not
    Run Keyword And Continue On Failure    Check Continue Button Enabled                xpath=//input[@id='paybill-user-number']                xpath=//button[contains(@class,'btn-disabled')][1]        ${Incorrect_No1}
    #Run Keyword And Continue On Failure    Check Continue Button Enabled                xpath=//input[@id='paybill-user-amount']                xpath=//button[contains(@class,'btn-disabled')][2]        100 
    
    #Invalid Number Verification
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][1]
    Text Verification                   xpath=//div[@id='dyn-sendotp-paybill-geninvalid']                  Please enter a valid Jio number/Service ID  
    #Clear Textfield
    Cross Button Functionality          xpath=//div[2]/div[1]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    #Cross Button Functionality          xpath=//div[contains(@class,'input-has-prefix')]//span[@class='input-icon input-icon-suffix clickable clear-btn']
    
    #Prepaid Number Verification
    Wait For And Input Text             xpath=//input[@id='paybill-user-number']        ${Number} 
    Wait For And Input Text             xpath=//input[@id='paybill-user-amount']        100 
    Wait For And Click Element          xpath=//button[contains(@class,'btn-disabled')][2] 

Select All Filters 
    #clicking filter button
    Wait For And Click Element          xpath=//section[contains(@class,'desktop')]//div[contains(@class, 'filterBtn')]//Button[2]
    ${checkboxes}=                      Get WebElements     xpath=//div[contains(@class,"j-modal-visible j-modal-closable")]//div[@class="FilterPopup_checkbox__10y7P"]
    ${len}=                             Get Length      ${checkboxes}
    log to console  ${len}
    FOR     ${i}    IN RANGE   1   ${len}+1   
        # selecting checkbox
        Wait For And Click Element          xpath=(//div[contains(@class,"j-modal-visible")]//div[@class="FilterPopup_checkbox__10y7P"]//span[@aria-label])[${i}]
    END
    #click on show plans button
    Wait For And Click Element          xpath=//div[contains(@class, 'visible')]//button[@aria-label='button'][normalize-space()='Show plans']

View all Sub plans button Redirection
    ${elements}=    Get WebElements         xpath=(//section[contains(@class,'desktop')]//button[contains(normalize-space(),'View all')])
    ${length}=      Get Length              ${elements}
    FOR     ${i}    IN RANGE   1  ${length}+1
        #Scroll to sub-plan title
        Scroll To                         xpath=(//section[contains(@class,'desktop')]//button[contains(normalize-space(),'View all')])[${i}]
  
        # Take Element Text of sub-plan title
        ${Plan Title}=                      Take Element Text        xpath=(//section[contains(@class,'desktop')]//button[contains(normalize-space(),'View all')])[${i}]
        # Clicking view all sub-plans button
        Wait For And Click Element         xpath=(//section[contains(@class,'desktop')]//button[contains(normalize-space(),'View all')])[${i}]
        
        # Verifying plan title
        Wait For And Verify Element          xpath=//section[contains(@class,'desktop')]//button[@class='j-tag active clickable'] 
        
        Take Page Screenshot                     ${Plan Title}_Sub-Plan_loaded
        
        # clicking on cross button above showing results
        Wait For And Click Element          xpath=//section[contains(@class,'desktop')]//button[@class='j-tag active clickable']
    END

Read Data

    [Arguments]  ${card}  ${sheet_name}  ${row_num} 

    ${cards_text}  Create List    

    ${elements_cnt}  Get Element Count  ${card}

    FOR  ${i}  IN RANGE   1  ${elements_cnt}+1

        ${text} =  SeleniumLibrary.Get Text  (${card})[${i}]
        Append To List  ${cards_text}  ${text}  

        Write Excel Cell  row_num=${row_num}  col_num=${i}  value=${text}  sheet_name=${sheet_name}

        Save Excel Document  filename=Resources/JioWeb.xlsx    

    END  

    [Return]  ${cards_text}

Fiber Plan Card Verification

    [Arguments]  ${cards}  ${sheet_name}  ${row_num}
    
    #Uncomment IF part to the write the data in excel
    
    # ${choice} =  Get Selection From User  Want to write data to excel?  Yes  No  
    # IF  "${choice}" == "Yes"

    #     ${text}  Read Data  ${cards}  ${sheet_name}  ${row_num}

    # END

    ${elements_cnt}  Get Element Count  ${cards}

    FOR  ${i}  IN RANGE   1  ${elements_cnt}+1  

        ${text} =  SeleniumLibrary.Get Text  (${cards})[${i}]

        # ${text} =  Split String  ${text}  separator=\n

        # ${text} =  Evaluate             "".join(${text})
        
        ${gt_txt} =  Read Excel Cell  ${row_num}  col_num=${i}  sheet_name=${sheet_name}
        
        Should Be Equal  ${text}  ${gt_txt}  strip_spaces=True

    END

Fiber More Information Buttons Redirection

    # Scroll to More information section
    Scroll To   xpath=//*[contains(@class,"desktop")]//*[contains(text(),"More information")]

    # This Will Get The Buttons Present Under More Information
    ${more_info_buttons}  Get Element Count  xpath=(//*[contains(@class,"desktop")]//*[contains(@class,"MoreInformation")]//button) | (//*[contains(@class,"MoreInformation_buttonCategoryCont")]//button)

    # Loop will iterate for all the buttons present under 'More Information' section
    FOR  ${button}  IN RANGE  ${more_info_buttons}

        # It Will Click The Button Present Under More Information Section
        Wait For And CLick Element            xpath=(//*[contains(@class,"MoreInformation")]//button)[${button+1}]

        # Below command will press the button(s) as per the loop iterator 'Button'
        Sleep        200ms

        # This Will Return The No Of Tabs Open In Browser
        ${tabs}  Get Window Handles  

        # This Will Return The Length Of The List
        ${no_of_tabs}  Get Length    ${tabs}

        # It will get the text of the button
        ${button_text}  Get Text    xpath=(//*[contains(@class,"MoreInformation")]//button)[${button+1}]

        # Once after the button click, pdf opens in different tab, so it'll switch to that tab to verify
        IF    ${no_of_tabs}>1

            # It will switch the window which opened up lastly
            Switch Window                  NEW

            # It will get the url of an active tab
            ${URL}  Get Location  

            # It will get the status whether the url is present in the URLs List or Not
            ${status}   Check If URL Contains  ${Fiber_more_information_URLs}    ${URL}  ${Button_text}

            IF  ${status}

                # It will capture the page screen shot and save it to the mentioned directory.
                Take Page Screenshot           Sc_Name=${button_text}_Confirmation

                # It will close the window
                Close Window

                # It will the switch to that window to close 2nd un-necessary opening tab
                Switch Window  url=${URL}

                # It will close 2nd un-necessary opened tab
                Close Window

                # It will switch the window back to previous one to carry the execution further.
                Switch Window                  MAIN

            ELSE  
                # it will halt the execution and prompt the appropriate message
                Run Keyword And Continue On Failure  Fail   ${button_text} URL Mismatch

                # It will close the window
                Close Window

                # It will the switch to that window to close 2nd un-necessary opening tab
                Switch Window  url=${URL}

                # It will close 2nd un-necessary opened tab
                Close Window

                # It will switch the window back to previous one to carry the execution further.
                Switch Window                  MAIN
            END
        ELSE

            # If in case only pop up opens up, it will take the screenshot.
            Take Page Screenshot           Sc_Name=${button_text}_Confirmation

            # It will close the opened pop up.    
            Wait For And Verify Element   xpath=(//*[contains(@class,"j-modal-visible")]//button[contains(@class,"icon")])
        END
    END

Need Guidance Section verification and button redirection
    
   # To Verify Need Guidance Section
   Scroll To                                          xpath=//section[@class='j-container bg--primary-background']
   Section Verification                               xpath=//section[@class='j-container bg--primary-background']           ${Need_Guidance_Text}[0]

   # To Verify Need Guidance text
   Text Verification                                  xpath=//h2[normalize-space()='Need guidance?']        ${Need_Guidance_Text}[0]

   # To Verify Sub Text
   Text Verification                                  xpath=//div[contains(text(),"We’d love to help you.")]        ${Need_Guidance_Text}[1]

   # To Get The Count Of Buttons Present Under Need Guidance Section
   ${need_guidance_buttons}=      Get Element Count                 xpath=//button[contains(@class,' j-button-flex')] | //*[contains(text(),"Need guidance?")]//ancestor::*[contains(@class,"j-contentBlock__body")]//a
   Log To Console  ${need_guidance_buttons} Buttons Present

   # To Check The Button Redirection Present Under Need Guidance Section
   FOR    ${button}   IN RANGE   ${need_guidance_buttons}
      
      # It will get the text of button
      ${button_text}  Get Text  xpath=(//button[contains(@class,' j-button-flex')])[${button+1}] | (//*[contains(text(),"Need guidance?")]//ancestor::*[contains(@class,"j-contentBlock__body")]//a)[${button+1}]

      # It will match the text of button
      ${status}  Check If URL Contains  ${Need_Guidance_Button_Text}  ${button_text}  ${button_text}   

      # Fails the keyword if text of button not matched
      Run Keyword If  ${status}=='False'  Run Keyword And Continue On Failure   Fail   ${button_text}  Mismatch

      # Clicks the button present under specified section one by one as the loop iterates
      Wait for and Click Element   xpath=(//button[contains(@class,' j-button-flex')])[${button+1}] | (//*[contains(text(),"Need guidance?")]//ancestor::*[contains(@class,"j-contentBlock__body")]//a)[${button+1}]

      # Sleep to get the page properly loaded
      Sleep  500ms
      
      # It will get the location of current tab
      ${URL}  Get Location

      # it will check the status of the loaded urls with ones actually stored in yaml file
      ${status}  Check If URL Contains  ${Need_Guidance_URLs}  ${URL}    ${button_text}

      # It will click the snapshot once status is true
      IF  ${status}
          Take Page Screenshot  ${button_text}_sc
          Go Back
      ELSE
          Run Keyword And Continue On Failure  Fail  ${button_text} URL Mismatch
          Go Back
      END
   END

Fiber View Details Pop up Verification
    [Arguments]   ${View_Button}  ${section}  ${Sheet_name}  ${row_num}  ${col_num}  ${Cross}

    #Bring "View Details" button into view
    Scroll To     ${View_Button} 
    Sleep    200ms 

    #Opening Popup
    Wait Until Keyword Succeeds     5sec  2sec  Open Popup  ${View_Button}          

    #Waiting until model loads
    Wait For And Verify Element    ${section} 

    #Getting Card details
    ${text} =  Get Text  ${section}

    #Uncomment IF part to write the data in excel
    #Write Excel Cell  row_num=${row_num}  col_num=${col_num}  value=${text}  sheet_name=${sheet_name}
    #Save Excel Document  filename=Resources/JioWeb.xlsx     

    #Fetching data from excel
    ${gt_txt} =  Read Excel Cell  row_num=${row_num}  col_num=${col_num}  sheet_name=${sheet_name}

    #Comparing data
    Should Be Equal  ${text}  ${gt_txt}  strip_spaces=True

    # Verifying if the cross icon is present
    Wait Until Keyword Succeeds     30sec  1sec    Wait For And Verify Element     ${Cross}

Link Verification
    [Arguments]        ${Locator}
    Sleep  100ms
    Page Should Contain Link    ${Locator}

 # Get JioFiber
Landing on Installation address page                

    # Entering name in name field
    Wait For And Input Text           xpath://input[@id="submitNumber"]    ${Name}

    # Entering number in number field
    Wait For And Input Text           xpath://input[@id="submitMobile"]    ${Prepaid_Number}

    # Clicking Generate OTP button
    Wait For And Click Element        xpath://button[@aria-label="button Generate OTP"]
    ${otp}=    Get Value From User    Enter OTP

    # Entering OTP
    Wait For And Input Text           xpath://input[@id="basic-input-testInput-code-block-0"]    ${otp}

    # Clicking on verify button
    Wait For And Click Element        xpath://button[@aria-label="button Verify"] 

Scroll To and click     [Arguments]  ${locator}
    Scroll To  ${locator}
    Click Element  ${locator}

Click on Fiber plans button redirection
    [Arguments]  ${section}
    Scroll To                                  xpath=//button[@aria-label='button ${section}']
    Wait For And Verify Element                xpath=//button[@aria-label='button ${section}']   
    Wait For and click element                 xpath=//button[@aria-label='button ${section}']

Filter Button Verification
    [Arguments]        ${title}

    # Scroll Till Filter button is visible
    Scroll To                           xpath=//section[contains(@class,'desktop')]//button[contains(@class,"secondary icon-primary icon-only")]  

    # Open Filter popup
    Open Popup                          xpath=//section[contains(@class,'desktop')]//button[contains(@class,"secondary icon-primary icon-only")]    
    Take Page Screenshot                Filter

    # Verifying 'Filter' Text
    Text Verification                   xpath=(//h4[(normalize-space()='Filter')])    Filter
    CSS Verification                    xpath=(//h4[(normalize-space()='Filter')])    font-weight   900  

    # Verifying Cross icon which is present at top right corner
    Wait For And Verify Element         xpath=//div[contains(@class,' j-modal-visible')]//header[@class='j-modal-header']//button[@aria-label='button']          
    # Verifying Show plans button
    Text Verification                   xpath=//button[@class="FilterPopup_showPlans__1eaSr j-button j-button-size__medium primary"]    Show plans
    
    # Button Verification of "Show plans button"
    Button Verification                 xpath=//button[@class="FilterPopup_showPlans__1eaSr j-button j-button-size__medium primary"]
    
    # Verifying Clear filter button
    Text Verification                   xpath=(//*[contains(@class,"j-modal-visible j-modal-closable")]//button[@class="j-button j-button-size__medium secondary"])    Clear filter
    
    # Button Verification of Clear filter button
    Button Verification                 xpath=(//*[contains(@class,"j-modal-visible j-modal-closable")]//button[@class="j-button j-button-size__medium secondary"])
    
    # List of plans with checkbox
    ${checkboxes}=                  Get WebElements     xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"]

   # Verifying the checkbox should not be selected
    FOR  ${checkbox}  IN  @{checkboxes}
        # Verifying the checkbox present
        Wait For And Verify Element             ${checkbox}

        # Verifying the checkbox should not be selected
        Checkbox Should Not Be Selected         ${checkbox}

    END

    # Gets the count of the checkbox present
    ${length}=                          Get Length      ${checkboxes}
    @{Plan_List}=       Create List

    # All planfilter & Clear button
    FOR     ${checkbox}    IN RANGE   1  ${length}+1

        # Clicks on all the checkbox present
        Wait For And Click Element          xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${checkbox}]//span[2]

        # Verifies that the checkbox is selected
        Checkbox Should Be Selected         xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${checkbox}]//input

        # Gets the text of the Plan name which is present to the right of the checkbox
        ${Plan_Name}=       Get Text        xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${checkbox}]
        Log To Console        ${Plan_Name}
        Append To List      ${Plan_List}    ${Plan_Name}
    END
    
    # Clicks on cross icon
    Wait For And Click Element              xpath=//div[contains(@class,' j-modal-visible')]//header[@class='j-modal-header']//button[@aria-label='button']

    # Verfying the filters are not applied
    Page Should Not Contain Element         xpath://*[contains(@class,"desktop")]//*[contains(text(),"Showing")]

    # Open Filter popup
    Open Popup                              xpath=//section[contains(@class,'desktop')]//button[contains(@class,"secondary icon-primary icon-only")]

    # Verifies Filter selection remains same
    Checkbox Should Be Selected            xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${checkbox}]//input

    #Clicks on Show plans
    Wait For And Click Element             xpath=//button[@class="FilterPopup_showPlans__1eaSr j-button j-button-size__medium primary"]

    # Gets the count of the cross icon present after selecting filters
    ${cross_icon}=    Get Element Count     xpath=//section[contains(@class,"desktop")]//button[contains(@class,'j-tag active clickable')]

    FOR    ${i}      IN RANGE   0  ${cross_icon}
        
        # Verfying the filters are applied
        Wait Until Keyword Succeeds    30sec    2sec     Page Should Contain Element    xpath=//*[contains(@class,"desktop")]//i[@class='j-tag-icon']//preceding-sibling::*//*[normalize-space()="${Plan_List}[${i}]"]
        
        # Getting the cards count present on page
        ${filter_count_variable}  Get Element Count  xpath=//*[contains(@class,"desktop")]//div[contains(@class,"planDetailsCard")]

        # Getting the count after applying the filter
        ${getting_count_text}  Get Text   xpath=//*[contains(@class,"desktop")]//*[contains(text(),"Showing")]

        # Comparing the count present after applying the filter
        Should Contain    ${getting_count_text}    Showing ${filter_count_variable} result    strip_spaces=true
        
        # Verifying the cross icon
        Wait For And Verify Element          xpath=//section[contains(@class,"desktop")]//button[contains(@class,'j-tag active clickable')][${i+1}]
    END

    # Open Filter popup
    Open Popup                              xpath=//section[contains(@class,'desktop')]//button[contains(@class,"secondary icon-primary icon-only")]

    # Clicks on Clear filter
    Wait For And Click Element              xpath=//button[@class="j-button j-button-size__medium secondary"]

    # Verifies after clicking on Clear filter , all the selected filters are cleared
    FOR  ${checkbox}  IN  @{checkboxes}
        # Checks if All selected filters are cleared
        Checkbox Should Not Be Selected         ${checkbox}
    END
    
    # Clicks on Show plans
    Wait For And Click Element          xpath=//button[@class="FilterPopup_showPlans__1eaSr j-button j-button-size__medium primary"]
    
    # Verifies user is redirected to the respective plan page
    Text Verification                                                xpath=//section[@class='j-container l-breakpoint--desktop']//h1[@class='Filter_category__2vFb8 j-text j-text-heading-l']   ${title}
    
    # Verfying No Results are visible    
    Page Should Not Contain Element        xpath=//*[contains(@class,"desktop")]//*[contains(text(),"Showing")]
    
    # Open Filter popup
    Open Popup                      xpath=//section[contains(@class,'desktop')]//button[contains(@class,"secondary icon-primary icon-only")]
    @{Plan_List}=       Create List

    # Selects the multiple filters
    FOR     ${i}    IN RANGE   1  ${length}+1
        # Clicks on all the filter after filter popup opens
        Wait For And Click Element          xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]//span[2]

        # Verifying that checkbox is selected after selecting multiple filters
        Checkbox Should Be Selected         xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]//input

        # Gets the text of the Plan name which is present to the right of the checkbox
        ${Plan_Name}=       Get Text        xpath=//div[contains(@class,' j-modal-visible j-modal-closable')]//div[@class="FilterPopup_checkbox__10y7P"][${i}]
        Log To Console        ${Plan_Name}
        Append To List      ${Plan_List}    ${Plan_Name}
    END

    # Selects the Show plans button
    Wait For And Click Element             xpath=//button[@class="FilterPopup_showPlans__1eaSr j-button j-button-size__medium primary"]

    # Logs the Plan Name
    Log                                 ${Plan_List}

    # Gets the count of the cross icon present after selecting filters
    ${cross_icon}=    Get Element Count     xpath=//section[contains(@class,"desktop")]//button[contains(@class,'j-tag active clickable')]
    FOR    ${i}      IN RANGE   0  ${cross_icon}
        # Verfying the filters are applied
        Wait Until Keyword Succeeds    30sec    2sec     Page Should Contain Element    //*[contains(@class,"desktop")]//i[@class='j-tag-icon']//preceding-sibling::*//*[normalize-space()="${Plan_List}[${i}]"]

        # Clicks on the cross icon of the applied filters
        Wait For And Click Element                       xpath=(//i[@class='j-tag-icon'])[1]

        # Verfying the filters are not applied
        Wait Until Keyword Succeeds    30sec    2sec     Page Should Not Contain Element    //*[contains(@class,"desktop")]//i[@class='j-tag-icon']//preceding-sibling::*//*[normalize-space()="${Plan_List}[${i}]"]

    END
    
    # Verfying No Results are visible
    Page Should Not Contain Element        xpath://*[contains(@class,"desktop")]//*[contains(text(),"Showing")]

Fiber Plan Page UI Verification
    # Keyword used in Fiber - Postpaid , Prepaid and Mobile - Postpaid and Prepaid

    # ${title} - Will verify the heading after the page opens after clicking on Monthly , Annual etc buttons
    # ${Other_Plans_title} - Will Verify the text of Other Postpaid Plans or Other Prepaid plans which is present above the More Information section 
    # ${Filter_presence} - Will Verify the presence of Filter if it is present . If the page does not contain Filter button , pass the argument as False
    # ${category_heading_presence} - Will Verify the presence of the speed sub heading present above the card . If the page does not contain any speed sub heading , pass the argument as False

    [Arguments]                      ${title}    ${Other_Plans_title}       ${Filter_presence}=True    ${category_heading_presence}=True
    
    # Title Verification  
    Text Verification                                                xpath=//section[@class='j-container l-breakpoint--desktop']//h1[@class='Filter_category__2vFb8 j-text j-text-heading-l']   ${title}

    # Verify Other Postpaid/Prepaid Plans Filter Button
    Wait For And Verify Element                                      xpath=//*[contains(@class,"desktop")]//button[contains(@class,"Filter")]  

    # Checks for filter and returns the status at run time
    ${filter_presence_status}  Run Keyword And Return Status         Wait For And Verify Element    xpath=//*[contains(@class,"filterBtn")]//button[2]

    # Verifies the presence of filter button in top-right
    Run Keyword And Continue On Failure  Should Be Equal As Strings  ${filter_presence_status}  ${filter_presence}
    
    # Returns the status of presence of Sub Category Heading
    ${subheading_presence_status}    Run Keyword And Return Status   Wait For And Verify Element    xpath=(//section[contains(@class,'desktop')]//div[@class="Subcategory_gridCont__2F4Pm"]//div[contains(@class,"Subcategory_heading")])[1]
    
    # Verifies the presence of sub category heading
    Run Keyword And Continue On Failure    Should Be Equal As Strings     ${subheading_presence_status}    ${category_heading_presence}           

    # Getting the count based on speed sub heading present
    ${length}=    Get Element Count                                  xpath=(//section[contains(@class,'desktop')]//div[@class="Subcategory_gridCont__2F4Pm"])
    IF  ${subheading_presence_status}
        FOR     ${index}    IN RANGE   1  ${length}+1
            # Getting that element into view 
            Scroll To                                                xpath=(//section[contains(@class,'desktop')]//div[@class="Subcategory_gridCont__2F4Pm"])[${index}]

            # Getting the text of the speed sub heading
            ${packname}=  Get Text                                   xpath=(//section[contains(@class,'desktop')]//div[@class="Subcategory_gridCont__2F4Pm"]//div[contains(@class,"Subcategory_heading")])[${index}]   
            Log To Console                                           ${packname}

            # Verifying the various plan card with speed sub heading
            Wait For And Verify Element                              xpath=(//section[contains(@class,'desktop')]//div[@class="Subcategory_gridCont__2F4Pm"])[${index}]
            Take Page Screenshot     ${packname}
        END 
    END
    
    # Getting the count of cards present
     ${card_count}=    Get Element Count                             xpath=//section[@class='j-container l-breakpoint--desktop']//section[@class='j-container bg--primary-20 l-radius--xl']  

     # Verfying each card is present
     FOR  ${plan_cards}  IN RANGE  1  ${card_count}+1 
         Wait For And Verify Element                                 xpath=(//section[@class='j-container l-breakpoint--desktop']//section[@class='j-container bg--primary-20 l-radius--xl'] )[${plan_cards}] 
    END

    # Other plans Title verification
    Text Verification                                                xpath=//section[@class='j-container l-breakpoint--desktop']//div[contains(@class,' j-text j-text-heading-l')]    Other ${Other_Plans_title} plans

    # Getting the count of Other Postpaid/Prepaid Plans buttons
    ${Other_Plans}=    Get Element Count                             xpath=//section[contains(@class,"desktop")]//button[contains(@class,"changeCategory_button__2ot94")]
    
    # Verifying each button present under Other Postpaid/Prepaid Plans buttons
    FOR  ${Plan_Name}  IN RANGE  1  ${Other_Plans}
         Wait For And Verify Element                                 xpath=//section[contains(@class,"desktop")]//button[contains(@class,"changeCategory_button__2ot94")][${Plan_Name}]
    END

    # More information Title Verification
    Text Verification                                                xpath=//section[contains(@class,'desktop')]//div[contains(@class,'MoreInformation_more')]    More information
  
    #Fetching the buttons under "More Information" section
    ${More_Information}=    Get Element Count                        xpath=//section[contains(@class,'desktop')]//div[contains(@class,'MoreInformation')]//button[contains(@class,'secondary')]

    # Verifying every button present under "More Information" 
    FOR  ${button}  IN RANGE  1  ${More_Information}
         Wait For And Verify Element                                 xpath=(//section[contains(@class,'desktop')]//div[contains(@class,'MoreInformation')]//button[contains(@class,'secondary')])[${button}]
    END

Best Selling JioFiber Accessories section
    Verify UI of Best Selling JioFiber Accessories section
    Scroll To                       xpath://section[@aria-label="jioaccessories"]
    Verify redirection of Best Selling JioFiber Accessories section    3

More from Jio section
    Verify Presence of More from Jio section
    Scroll To                       xpath://section[@aria-label="More from Jio"]
    Verify Redirection of More from Jio Promo cards    2

Verify Banner redirection
    
    # Clicking on banner and checking the redirection
    Redirection On Clicking           xpath:(//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']//div[@class='j-promo-card__content-body'])[1]     ${Services_URLs[0]}    Service_Banner_redirect   

Verify Presence of Banner
    
    # Verifying if banner is visible
    ${presence}=  Run Keyword And Return Status  Wait For And Verify Element  xpath://div[@class="j-card__flex j-flex-column-reverse"]
    Run Keyword If  ${presence}==False   Wait For And Verify Element          xpath://section[@class="j-container l-layout--max-width"]//section[@role="promo-banner"]

Verify Get JioFiber button redirection

    # Clicking on Get JioFiber button and checking the redirection
    Redirection On Clicking           xpath://button[@aria-label="Get JioFiber"]   ${Services_URLs[0]}    Get_JioFiber_redirect

Verify Tiles are present under Distinguished features
    [Arguments]    ${total_cards}
    
    # For loop to check visibility of cards.
    FOR  ${card}  IN RANGE    0    ${total_cards}

        # Verifying that card is present. 
        ${status}=  Run Keyword And Return Status  Wait For And Verify Element  xpath:(//section[contains(@aria-label,"Distinguished features")]//div[@class="j-card__flex"])[${card+1}]
        Run Keyword If  ${status}==False  Wait For And Verify Element           xpath:(//div[@class="j-card__flex"])[${card+1}]

    END

Verify Functionality of Video cards
    [Arguments]    ${total_videos}

    
    # For loop to Click on every video tile and checking functionality
    FOR  ${video}  IN RANGE    0    ${total_videos}

        # waiting for elements to load
        Sleep    6s

        # Storing Video card heading in the variable
        ${title}=    Get Text                    xpath:(//div[@class="j-card h-100 size--xs card-vertical j-card__has-fullCardCTA no-top-padding j-card__shadow"])[${video+1}]

        # Scrolling Video cards into View
        Scroll To                 xpath:(//div[@class="j-card h-100 size--xs card-vertical j-card__has-fullCardCTA no-top-padding j-card__shadow"])[${video+1}]
        
        # Clicking on Video card
        Click Element                            xpath:(//div[@class="j-card h-100 size--xs card-vertical j-card__has-fullCardCTA no-top-padding j-card__shadow"])[${video+1}]

        # Verifying that the title of Video matches with title of Video card
        Wait For And Verify Content              xpath:(//div[@class="j-card h-100 size--xs card-vertical j-card__has-fullCardCTA no-top-padding j-card__shadow"])[${video+1}]    ${title}

        # Waiting till the iframe(youtube window) is visible
        ${status}=     Run Keyword And Return Status      Wait Until Element Is Visible      xpath://iframe[contains(@src,'https://www.youtube.com/embed/')]    15s
    
        IF  ${status} == True

            # Selecting iframe with youtube video
            Select Frame                             xpath://iframe[contains(@src,'https://www.youtube.com/embed/')]

            # Waiting for iframe to load
            Sleep    2s

            # Verifying if video is playing or not
            Wait Until Page Contains Element         xpath://div[contains(@class,'playing-mode')]    15s

            # Unselecting youtube iframe
            Unselect Frame      

        ELSE
            
            # Selecting iframe with youtube video
            Select Frame                xpath://iframe[contains(@src,"how-to-set-up-jio-set-top-box")]

            # Waiting for iframe to load
            Sleep    2s

            # Unselecting youtube iframe
            Unselect Frame

        END

        # Clicking on cross button
        Wait For And Click Element               xpath://button[@class="j-button j-button-size__medium tertiary icon-primary icon-only"]
    END

Verify redirection of Best Selling JioFiber Accessories section
    [Arguments]    ${total_product}

    # For loop to check redirection of product cards
    FOR  ${product}  IN RANGE    0    ${total_product}

        # Clicking product cards and checking redirection
        Redirection On Clicking                xpath://section[@aria-label="jioaccessories"]//div[@class="h-100"][${product+1}]    ${Services_URLs[${product+1}]}    accessories${product+1}
    END

    # Checking redirection of View all accessories button
    Sleep    3s
    Wait For And Verify element                  xpath=//button[@aria-label="View all accessories"]
    Redirection On Clicking                      xpath://button[@aria-label="View all accessories"]    ${Services_URLs[4]}    Accessories_page

Verify UI of Best Selling JioFiber Accessories section

    # Verifying if section is Visible
    Section Verification                  xpath://section[@aria-label="jioaccessories"]    Best Selling JioFiber Accessories

    # Verifying Title of the section
    Text Verification                     xpath://h3[contains(text(),"Best Selling JioFiber accessories")]    Best Selling JioFiber accessories

    # Storing total count of shop cards in variable
    ${cards_count}=    Get Element Count               xpath://div[@class="h-100"]//a[@class="j-link j-card__hidden-cta"]

    # Checking if count is matched to 3
    Should Be Equal As Integers       ${cards_count}    3

    # Verifying if View all accessories button is visible
    Wait For And Verify Element                  xpath://button[@aria-label="View all accessories"]

Verify Presence of More from Jio section

    # Verifying if more from jio section is visible
    Section Verification                  xpath://section[@aria-label="More from Jio"]    More from Jio

    # Verifying Title of the section
    Text Verification                     xpath://h3[contains(text(),"More from Jio")]    More from Jio

Verify Redirection of More from Jio Promo cards
    [Arguments]    ${total_banners}

    # For loop to check the redirection of Promo cards
    FOR  ${banner}  IN RANGE    0    ${total_banners}

        # Clicking on Promo cards and checking redirection
        Redirection On Clicking                  xpath:(//div[@class="j-promo-card__content-body"]//h4[@class="j-heading j-text-heading-s"])[${banner+1}]    ${Services_URLs[0]}    More_from_jio_redirect

    END

Verify Functionality of accordians of FAQs section
    [Arguments]    ${total_FAQs}

    # Scrolling down to FAQs section
    Scroll To                                  xpath://section[@aria-label="faqs section"]

    # For loop to checking accordion functionality
    FOR  ${faq}  IN RANGE    0    ${total_FAQs}

        # Clicking "+" icon to expand FAQ
        Wait For And Click Element               xpath:(//span[contains(@class,"accordion")]//*[local-name()='path' and contains(@d,"M20")])[${faq+1}]
        Sleep    2s

        # Verifying icon is changed to "-"
        Wait For And Verify Element              xpath:(//span[contains(@class,"accordion")]//*[local-name()='path' and contains(@d,"M3.293")])

        # Verifying that the FAQ is expanded
        Element Attribute Value Should Be        xpath:(//div[@class="j-accordion"]/div[@class="j-accordion-panel active"])   aria-expanded    true  

        # Clicking "-" icon to collapse FAQ
        Wait For And Click Element               xpath:(//span[contains(@class,"accordion")]//*[local-name()='path' and contains(@d,"M3.293")])
        Sleep    2s

        # Verifying icon is changed to "+"
        Wait For And Verify Element              xpath:(//span[contains(@class,"accordion")]//*[local-name()='path' and contains(@d,"M20")])[${faq+1}]

        # Verifying that the FAQ is collapsed
        Element Attribute Value Should Be        xpath:(//div[@class="j-accordion"]/div[@class="j-accordion-panel"])[${faq+1}]    aria-expanded    false  

    END

Verify Heading & Sub-Heading
    [Arguments]  ${Heading}  ${Sub_Heading}
    Scroll To  ${Sub_Heading}
    Sleep  2s 
    Mouse Down  ${Heading}

Button Verification
    [Arguments]                             ${locator}
    Scroll To                             ${locator}
    Wait Until Element Is Visible           ${locator}
    Page Should Contain Button              ${locator}

Toast Capture and Data Validation
    [Arguments]    ${SC_name}    ${locator}    ${ToastTitle}
    Sleep    1s
    Wait For And Verify Content    ${locator}    ${ToastTitle}   
    Take Page Screenshot    ${SC_name}-Page-Screenshot
    Log To Console    "${ToastTitle} found on Toast"
  
Redirection On Clicking_Button
   [Arguments]       ${Button}          ${WebPageURL}    ${Sc_name}   ${Landing_Back_Url} 
    Scroll To            ${Button}                 
    Wait For And Click Element          ${Button}              
    Sleep     5s
    Log To Console    ${WebPageURL}
    URL Validation                      ${WebPageURL}
    Take Page Screenshot                     ${Sc_name}
    Go To                               ${Landing_Back_Url}
    Log To Console                      ${Sc_name} Redirection Successful

Logo Verification
    [Arguments]                             ${locator}  
    Wait Until Element Is Visible           ${locator}    10s
    Element Should Be Visible               ${locator}

#------------------------------------------------------------------------- Shop Page --------------------------------------------------------------------
Banner Content
    [Arguments]                     ${Txt_locator}      ${txt}  ${Sub_Txt_locator}      ${Sub_txt}         ${Img_locator}  ${Btn_locator}   ${Scn_Name}
    Text Verification               ${Txt_locator}      ${txt}
    Wait For And Verify Element              ${Img_locator}
    Text Verification               ${Sub_Txt_locator}      ${Subtxt}
    ${Buttons}=      Get WebElements     ${Btn_locator}
    FOR  ${Button}  IN  @{Buttons}
        Mouse Over                      ${Button}
        Page Should Contain Button      ${Button}   
    END    
    Take Page Screenshot                 ${Scn_Name}
    Log To Console                  ${Scn_Name} Section Content Verified

Check Most Popular and Most Value section
    #Verifying Whether Most Popular and Most Value Title section are visible
    Wait For And Verify Content    (//span[@class='most-pop-title'])[1]     Most Popular
    Wait For And Verify Content    (//span[@class='most-pop-title'])[2]     Most Value

Check UI of Most Popular and Most Value section
    # Most Popular and Most Value section Verification                                      Testcase: 92694,92764,92570
    Check Most Popular and Most Value section
    # Most Popular and Most Value section UI and Functionality Verification                 Testcase: 92695,92696,92765,92571,92572
    Checking UI Element Most Popular and Most Value section

Checking UI Element Most Popular and Most Value section
    #Iteration through Most Popular and Most Value section Products
    FOR    ${counter}    IN RANGE    1    3    
        #Checking Whether product tile is visible 
        Wait For And Verify Element    (//div[@class='col-lg-12 pop-image-cont'])[${counter}]

        #Checking Whether product Image is visible 
        Wait For And Verify Element    (//div[@class='col-lg-12 pop-image-cont'])[${counter}]
        
        #Checking Whether product content is visible 
        Wait For And Verify Element    (//div[@class='col-lg-12 pop-content-contnr'])[${counter}]
        
        #Checking Whether product title is visible 
        Wait For And Verify Element    (//div[@class='col-lg-12 pop-content-contnr'])[${counter}]//div[@class='pop-prod-title']
        ${name}=    Get Text           (//div[@class='col-lg-12 pop-content-contnr'])[${counter}]//div[@class='pop-prod-title']
        
        #Checking Whether product description is visible 
        Wait For And Verify Element    ((//div[@class='col-lg-12 pop-content-contnr'])[${counter}]//div[@class='pop-prod-desc'])[1]
        ${desc}=    Get Text           ((//div[@class='col-lg-12 pop-content-contnr'])[${counter}]//div[@class='pop-prod-desc'])[1]
        Wait For And Verify Element    ((//div[@class='col-lg-12 pop-content-contnr'])[${counter}]//div[@class='pop-prod-desc'])[2]
        ${price}=    Get Text          ((//div[@class='col-lg-12 pop-content-contnr'])[${counter}]//div[@class='pop-prod-desc'])[2]

        Reading Most Popular/Value Data from Excel    ${counter+12}    ${sheet}

        Should Be Equal    ${name}    ${Prod_info}[0]
        Should Be Equal    ${desc}    ${Prod_info}[1]
        Should Be Equal    ${price}   ${Prod_info}[2]
        # Click on any product card            Testcase : 92766
        Wait For And Click Element     (//div[@class='col-lg-12 pop-image-cont'])[${counter}]
        
        #Confirming Redirection of Product Link
        ${name_page}=    Get Text     //h2[@itemprop='name']
        Should Contain    ${name}    ${name_page}
       
        Go Back

        
    END

Scrolling to All Products
    Scroll To    xpath://div[@class='col-lg-12 prod-title-wrap']
    Wait For And Verify Content    xpath://div[@class='col-lg-12 prod-title-wrap']    All Products

Checking Product Name
    #Verify smartphone name from Excel
    
    #Getting Value from Page
    ${value_name} =    Get Text    //div[contains(@class,"product-container") and contains(@onclick,"${URL_listShop[${Product_name}-1]}")]//div[@class="pop-prod-title"]
    #Reading Value from Excel
    ${value1_name} =    Reading Data of Shops Page from Excel    ${Product_name+18}    1    ${sheet}
    Set Test Variable    ${value_name}
    Should Be Equal As Strings    ${value_name}    ${value1_name}

Checking Product Specs
    #Verify smartphone specs from Excel

    #Getting Value from Page (Taking Storage & Colour)
    ${value} =    Get Text    //div[contains(@class,"product-container") and contains(@onclick,"${URL_listShop[${Product_name}-1]}")]//div[@class="pop-prod-desc mg-bt-8"]
    #Reading Value from Excel
    ${value1} =    Reading Data of Shops Page from Excel    ${Product_name+18}    2    ${sheet}
    #Checking Whether Value is Empty or not
    ${len} =    Get Length    ${value}
    IF    ${len} > 0
        Should Be Equal As Strings    ${value}    ${value1}
    END

Checking Product Price
    #Verify smartphone price from Excel
    #Getting Value from Page
    ${value} =    Get Text    //div[contains(@class,"product-container") and contains(@onclick,"${URL_listShop[${Product_name}-1]}")]//div[@class="pop-prod-desc mg-bt-0"]
    #Removing Unnecessary characters
    ${value}=    Remove String    ${value}    ,
    ${value}=    Remove String    ${value}    ₹
    #Reading Value from Excel
    ${value1} =    Reading Data of Shops Page from Excel    ${Product_name+18}    3    ${sheet}
    
    Should Be Equal As Strings    ${value}    ${value1}

Checking Redirection on Product
    #Verify Smartphone URL From Excel
    ${Vurl} =    Reading Data of Shops Page from Excel    ${Product_name+18}    4    ${sheet}
    Wait For And Click Element    xpath=//div[contains(@class,"product-container") and contains(@onclick,"${URL_listShop[${Product_name}-1]}")]
    URL Validation    ${Vurl} 

Checking View Details 
    #Verify popup UI after clicking  View Details hyperlink
    Wait For And Click Element    xpath=//div[@class="view-emi-button"]

    #Verifying Buttons and content of EMI
    Wait For And Verify Element   xpath=//button[@class="close"]
    Wait For And Verify Content   xpath=//div[@class="popup-heading"]    EMI options
    Wait For And Verify Content   xpath=//div[@class="top-section"]    Choose your bank to view plans (Credit cards only)
    Wait For And Verify Element   xpath=//select[@id="selectFromBank"]

    #Functionality of EMI pop-up
    Wait For And Click Element    xpath=//select[@id="selectFromBank"]
    Wait For And Click Element    xpath=//option[@value='10']
    Wait For And Verify Element   xpath=//div[@id='bank-10-emi-table']
    Wait For And Click Element    xpath=//button[@class="close"]

Pincode Verification
    Scroll To                    xpath=//input[@aria-label="Enter Pincode"]

    #Input Wrong Pincode Less Than Six Digits And Click Check Button         Testcase:92675
    Wait For And Input Text      xpath=//input[@id="address.postcode"]    40060
    Wait For And Click Element   xpath=//button[@id="pincode-button"]
    # Wrong & Invalid pincode verification
    Wait For And Verify Content  xpath=//div[@class="digital-pincode-validations error-text validation-msg pin-code-input-error"]    Please enter a valid 6 digit pincode
    
    # Entering Wrong Pincode                Test Case : 92791,92584
    Wait For And Input Text      xpath=//input[@id='address.postcode']    123456
    # Clicking Check Button
    Wait For And Click Element   xpath=//button[@id='pincode-button']
    # Invalid Pincode Error
    Text Verification           xpath=//div[@class='digital-pincode-validations error-text validation-msg pin-code-input-error']    Invalid Pincode
    
    IF  "${sheet}" == "Shop_Accessories"
        Confirm the functionality of Click here text
    END 
    
    # Checking if Add to Cart button is disabled or not                    
    Scroll To                       xpath=//button[@id="AddToCartBTN"]
    Element Should Be Disabled      xpath=//button[@id="AddToCartBTN"]
    
    
    #Input Correct Pincode And Click Check Button             Test Case : 92773,92585
    Scroll To                   xpath=//input[@id="address.postcode"] 
    Wait For And Input Text     xpath=//input[@id="address.postcode"]    ${PIN_Code}
    # Checking Check Button Is Enabled  While  Entering Pincode               Testcase: 92674
    Element Should Be Enabled    xpath=//button[@id='pincode-button']
    # Clicking Check Button 
    Wait For And Click Element  xpath=//button[@id="pincode-button"]


    #Check for Stock Availability status            
    TRY
        #If Stock is Unavailable
        Wait Until Page Contains    Stock unavailable
        Stock Unavailable For Pincode                                        #Testcase: 92677
    EXCEPT
        #If Stock is Available
        Wait Until Page Contains    Stock available                          #Testcase: 92676
        Stock available For Pincode
        Confirm the functionality and UI of Quantity & Add to cart           #Testcase: 92586
        
    END
    
Stock Unavailable For Pincode

    #Verify UI when a Product is unavailable
    Wait For And Verify Content     //div[@class="servicability-message-container"]/div/p    Stock unavailable for ${PIN_Code}
    
    #Color of Product unavailable Text
    CSS Verification                //div[@class="servicability-message-container"]/div/p    color    rgba(245, 0, 49, 1)

    # 'Product not available at this pincode'
    Wait For And Verify Element     //div[@class='desktop-body-m']
    
    #Cross Svg
    Wait For And Verify Element     //div[@id="ItemOutOfStock"]/div[@class="success-svg-container"]
    
    # Checking change pincode button and Functionality
    Wait For And Verify Element     //button[@class="change-pin-code-btn width-50pc"]
    Wait For And Click Element      //button[@class="change-pin-code-btn width-50pc"]
    Wait For And Verify Element     //input[@id='address.postcode']
    Wait For And Click Element      //button[@id='pincode-button']
    
    # Verifying Notify Me Button UI and Functionality
    Wait For And Verify Element     //button[@id="notifyyMe"]
    ${notify}=    Run Keyword And Return Status    Element Attribute Value Should Be    xpath=//button[@id="notifyyMe"]    style    opacity: 1;
    Run Keyword If    ${notify}    Notify Me Button UI Verification & Functionality     #possibly Site Issue    Testcase: 92678,Testcase: 92680 , Testcase: 92583

    #Checking if Add to Cart button is disabled or not                              Testcase: 92686                     
    Element Should Be Disabled      //button[@id="AddToCartBTN"]    

Stock available For Pincode
    # Color of Product available Text
    Wait For And Verify Content    //div[@class="servicability-message-container"]/div/p    Stock available for ${PIN_Code}
    
    #Color of Product available Text
    CSS Verification              //div[@class="servicability-message-container"]/div/p    color    rgba(37, 171, 33, 1)
    
    #Tick Svg
    Wait For And Verify Element    (//div[@class="localityAdditionalInfo"]//div[@class="success-svg-container"])[4]
    
    # Checking text 'Standard Delivery by'
    Wait For And Verify Element    xpath=//div[contains(text(),"Standard Delivery")]
    # Verifying Date of Delivery Span 
    Wait For And Verify Element    xpath=//div[@id="nonExpressDelInfo"]//div[@id="expressMsgText"]/span
    ${presence}=    Run Keyword And Return Status    Wait Until Element is visible   xpath=//div[@class='digital-cod-message jio-pdp-cod-available']//div[@id='expressMsgText']
    IF  ${presence} == True

        # Stock Available & Cash On Delivery Possible
        Text Verification                     xpath=//div[@class='digital-cod-message jio-pdp-cod-available']//div[@id='expressMsgText']     Cash on Delivery is available for this pincode 
        Wait For And Verify Element           xpath=(//div[@class="localityAdditionalInfo"]//*[local-name()='svg'])[5]

        #Stock Available & Cash On Delivery Possible Color Verification
        CSS Verification                      xpath=(//div[@class="localityAdditionalInfo"]//*[local-name()='svg'])[5]    color    rgba(26, 135, 60, 1)

    ELSE

        # Stock Available but Cash on Delivery not possible
        Text Verification                     xpath=//div[@class='digital-cod-message jio-pdp-cod-unavailable']//div[@id='expressMsgText']     Cash on Delivery is not available for this pincode 
        Wait For And Verify Element           xpath=(//div[@class="localityAdditionalInfo"]//*[local-name()='svg'])[5]
        
        # Stock Available But Cash On Delivery Not Possible Color Verification
        CSS Verification                      xpath=(//div[@class="localityAdditionalInfo"]//*[local-name()='svg'])[5]    color    rgba(82, 85, 94, 1) 
    END
    # Checking Add To Cart Button Is Enabled Or Not                                    Testcase: 92687
    Element Should Be Enabled     //button[@id="AddToCartBTN"]
    
    # Verifying Input Box
    Wait For And Verify Element   //div[@class="pin-code-txt-btn"]    

Checking "Add To Cart" UI
    #Verify popup UI after Pressing Add To Cart button
    Sleep    200ms            #Required Sleep
    # Verifying Add to Cart Button
    Wait For And Verify Element    //button[@id="AddToCartBTN"]
    # Clicking Add to Cart Button
    Wait For And Click Element    //button[@id="AddToCartBTN"]
    # Verifying Cross Button 
    Wait For And Verify Element    //div[@class="digi-popup-closebtn digi-stj-headmarg"]
    # Verifying Heading
    Wait For And Verify Content    //div[@class="digi-cartpopup-title desktop-heading-xs"]    Product has been added to your cart!
    # Verifying Subheading
    Wait For And Verify Content    //div[@class="digi-cartpopup-confirm mg-bt-16 mobile-body-s"]    Would you like to explore more products or go to cart?
    # Verifying Go to Cart Button
    Wait For And Verify Element    //div[@id="digi-cartpopup-GotoCart"]
    # Verifying Continue Shopping Button
    Wait For And Verify Element    //div[@id="digi-cartpopup-ContinueShopping"]
    
Checking Image Carousel
    Wait For And Verify Element    //div[@id="primary_image"]//img
    Wait For And Verify Element    //div[@class=" jcarousel-skin"]

Checking Device Specs & View Details
    Scroll To                      //h2[@itemprop="name"]
    Wait For And Verify Element    //h2[@itemprop="name"]
    Wait For And Verify Element    //div[@class="price-holder"]

    #Checking Whether Discount is Present 
    ${discount_price}=    Run Keyword And Return Status    Wait Until Page Contains Element   //span[@class="discount-price-holder"]    timeout=1s
    IF    ${discount_price} == True
        Wait For And Verify Element    //span[@class='discount-price-holder']/s
        Wait For And Verify Element    //div[@class='discount-teaser']
    END

    #Getting Value from page
    ${prod_price}=     Get Text        //span[@class='product-price']

    #Removing Unnecessary Characters
    ${prod_price}=     Remove String     ${prod_price}    ,
    ${prod_price}=     Remove String     ${prod_price}    ₹    

    #Converting String to Integer
    ${prod_price}=    Convert To Integer    ${prod_price}

    #EMI is not present for product under 2499 & Checking View Details 
    IF    ${prod_price}>2499
        Wait For And Verify Content    //div[@class="emi-description"]/span    EMI starts from
        Checking View Details                                     
    END

Checking "About Item"
    #About this item title
    Wait For And Verify Content    //div[@class="description-title"]/span    About this item
    #ABout this item content
    Wait For And Verify Element    //div[@class="description-content"]
    #"View all specifications hyperlink"
    Wait For And Verify Content    //div[@class="description-button-block"]/span   View all specifications

Checking Pincode
    #Checking Title of Pincode Section
    Wait For And Verify Content    //div[@class="desktop-heading-xs pin-code-input"]    Eligible for delivery?
    #Checking Pincode Input Field
    Wait For And Verify Element    //input[@id="address.postcode"]
    #Checking Check Button 
    Wait For And Verify Element    //button[@id="pincode-button"]
    # Checking Check Button Is Enabled Or Not Without Entering Pincode
    Element Should Be Enabled    xpath=//button[@id='pincode-button']

Checking Colour
    #Verifying Colour Section
    Wait For And Verify Element    //div[contains(@class, "colour-content")]
    #Text Verification of Title
    Wait For And Verify Content    //div[@class="colour-div"]/span    Colour
    #Verifying Colour Selection
    Wait For And Verify Element    //div[@class="colour-block"]

Checking Version
    ${Version_Visible}=    Run Keyword And Return Status    Wait For And Verify Element    xpath=//div[contains(@class, "version-container")] 
    IF  ${Version_Visible}  
        #Checking Version Section
        Wait For And Verify Content    //div[contains(@class, "version-container")]    Version
        #Checking Version Selection Section
        Wait For And Verify Element    //div[contains(@class, "version-list-block")]
    END

Checking Storage
    ${itel_presence}=    Run Keyword And Return Status    Should Not Contain    ${value_name}    Itel
    IF    ${itel_presence}
        #Checking Storage Section
        Wait For And Verify Content    //div[contains(@class, "storage-container")]    Storage
        #Checking Storage Selection Section
        Wait For And Verify Element    //div[contains(@class, "storage-container")]/div
    END    

Checking Quantity
    #Button Verification of Decrement button
    Button Verification    //button[contains(@class, "qty-decrement")]
    #Button Verification of Increment button
    Button Verification    //button[contains(@class, "qty-increment")]
    #Button Verification of Add to Cart button
    Button Verification    //button[@id="AddToCartBTN"]

Checking Policy
    #Verifying Return Policy Section Text
    Wait For And Verify Content    //div[@class="prod-return-policy-text"]/span    For our return policy
    Wait For And Verify Content    //div[@class="prod-return-policy-link"]/a    Click here
    Wait For And Verify Content    //div[@class="sales-distribution-block"]/span    Sale & distribution by Reliance Retail Ltd.

Checking Accordion
    #Checking Key Features Accordion Section
    Wait For And Verify Element    //a[@title="Key Features"]
    #Checking Whether Key Features Accordion is expanded or not
    ${expanded} =    Get Element Attribute    //a[@title="Key Features"]    aria-expanded
    IF  "${expanded}" != "true"
        Fail
    END
    #Checking Shipping & Delivery Accordion Section
    Wait For And Verify Element    //a[@title="Shipping & Delivery"]
    #Checking Offers & Information Accordion Section
    Wait For And Verify Element    //a[@title="Offers & Information"]
    #Checking Technical Specs Accordion Section
    Wait For And Verify Element    //a[@id="tab-specification-link"]

SlideShow Gallery Verification
    #Get the name of the Product
    ${itemname} =    Get Text    //h2[@itemprop="name"]

    #Get the number of gallery pics
    ${gallerypics} =    Get Element Count    xpath://img[@data-primaryimagetitle="${itemname}"]

    #Loop for the number of gallery pics
    FOR  ${number_products}  IN RANGE    0   ${gallerypics} 
        IF  ${number_products} > 3 

            #Press the vertical down button
            Wait For And Click Element    //div[@class="jcarousel-next jcarousel-next-vertical"] 
                   
        END

        #Click on a gallery pic
        Wait For And Click Element               //img[@data-galleryposition="${number_products}"]
        Sleep    2s   #Site Issue Please do not remove
        #Verify that selected pic is on big image
        ${imgsrc1} =    Get Element Attribute    //img[@data-galleryposition="${number_products}"]    data-primaryimagesrc
        ${id} =    Get Location
        ${id1} =    Fetch From Right    ${id}    /
        ${imgsrc2} =    Get Element Attribute    xpath://img[@id="${id1}"]    src
        ${imgsrc2new} =    Remove String    ${imgsrc2}     https://www.jio.com
        Should Be Equal As Strings    ${imgsrc1}    ${imgsrc2new}
    END
    
Confirm redirection of the breadcrumbs hyperlinks
    #Checking Which Sub-Module is Executing 
    IF    "${sheet}" == "Shop_Smartphone"
        Wait For And Verify Content    (//div[@class='j-breadcrumbs__item'])[2]   Smart Phones     
        ${z}    Set Variable    1
    ELSE IF    "${sheet}" == "Shop_SmartDevices"
        Wait For And Verify Content    (//div[@class='j-breadcrumbs__item'])[2]    Smart Devices  
        ${z}    Set Variable    2
    ELSE IF    "${sheet}" == "Shop_JioFi"
        Wait For And Verify Content    (//div[@class='j-breadcrumbs__item'])[2]    JioFi  
        ${z}    Set Variable    3
    ELSE IF    "${sheet}" == "Shop_Accessories"
        Wait For And Verify Content    (//div[@class='j-breadcrumbs__item'])[2]    Jio Accessories    
        ${z}    Set Variable    4
    END
     
    Scroll To                      //a[@aria-label='Breadcrumbs-1'][normalize-space()='Shop']
    #Verifying Redirection of First Breadcrum
    Redirection On Clicking       //a[@aria-label='Breadcrumbs-1'][normalize-space()='Shop']    ${Shop_SubNavBar_URL}[0]    First_Breadcrum    
    #Redirection On Clicking       (//div[@class='j-breadcrumbs__item'])[2]    ${Shop_SubNavBar_URL}[${z}]    Second Breadcrum Redirection  
    ${breadcrum_href}=    Get Element Attribute       (//div[@class='j-breadcrumbs__item'])[2]//a    href
    Wait For And Click Element    (//div[@class='j-breadcrumbs__item'])[2]//a
    ${redirection_url}=    Get Location
    IF    "${breadcrum_href}" == "${redirection_url}"
        Go Back
    ELSE
        Fail
    END

Checking "View All Specifications"
    # Checking Ui Of View All Specifications
    Wait For And Verify Content                                xpath=//div[@class="description-button-block"]/span    View all specifications

    # Scrolling to Pincode
    Scroll To                                                  xpath=//div[@class='desktop-heading-xs pin-code-input']

    # Clicking on View all specifications
    Wait For And Click Element                                 xpath=//div[@class="description-button-block"]
    
    Sleep    2s                    #Required Sleep
    #Verifying Whether View all Specifications is Expanded or not
    Wait For And Verify Element                                xpath=//a[@id="tab-specification-link"]
    ${Tab_specs}=    Get Element Attribute    //a[@id="tab-specification-link"]    aria-expanded
    IF  "${Tab_specs}" == "true"
        #Checking Technical Specs Table is Visible
        Wait For And Verify Element                                xpath=//table[@class="feature-class-table"]
    ELSE
        Fail
    END

Notify Me Button UI Verification & Functionality
    
    Wait For And Click Element        xpath=//button[@id="notifyyMe"]
    #Verfying Notify Me Popup is Opened
    Page Should Contain            Notify me
    Page Should Contain            Enter your email and phone number

    #verfying Input Text Box
    Wait For And Verify Element        xpath=//input[@id='notifyEmail']
    Wait For And Verify Element        xpath=//input[@id='notifymobilenumber']
    Button Verification                xpath=//button[@onclick="document.getElementById('notifypopup').style.display='none'"]
    Button Verification                xpath=//button[@id='notifySubmit']
    Wait For And Verify Element        xpath=//div[@onclick="document.getElementById('notifypopup').style.display='none'"]//*[name()='svg']
    
    #Checking Notify Me Popup Functionality
    Input Text        xpath=//input[@id='notifyEmail']          123@gmail.com
    Input Text        xpath=//input[@id='notifymobilenumber']    1234567890
    # Notify Me Submit Button Verification
    Button Verification           xpath=//button[@id='notifySubmit']
    # Clicking  Notify Me Submit Button 
    Wait For And Click Element    xpath=//button[@id='notifySubmit']
    # Message After Clicking Submit Button 
    Wait For And Verify Content   xpath=//div[@class='success-message-popup']    You will be notified when the product will be available for delivery.
    # Clicking Notify Me Button 
    Button Verification           xpath=//button[@id='notifyClose']
    Wait For And Click Element    xpath=//button[@id='notifyClose']
   
Confirm the functionality and UI of Quantity & Add to cart
    Scroll To                         xpath=//button[@class="qty-increment"]
    
    #Checking Decrement Button Disabled
    Wait For And Verify Element       xpath=//button[@class='qty-decrement btnDisabled']

    #Increasing Product Quantity
    Wait For And Click Element        xpath=//button[@class="qty-increment"]

    #Checking Whether Product has reached its Quantity Limit
    ${Quantity_limit}=    Run Keyword And Return Status    Wait For And Verify Element        xpath=//div[@class='max-limit-rchd']
    IF      ${Quantity_limit}
        #Checking For Error Message
        Wait For And Verify Content        xpath=//div[@class='max-limit-rchd']    Maximum limit reached!
        
        #Checking Whether Increment button is disabled 
        Wait For And Verify Element        xpath=//button[@aria-label='Increase quantity']
        Checking "Add To Cart" UI                                                  #Testcase: 92685,92588
        Redirection On Clicking            xpath=//div[@id="digi-cartpopup-GotoCart"]    ${Cart_URL}    Shopping_cart    #Testcase: 92589
    ELSE
        #Verfying Product Quantity Increased
        Wait For And Verify Content        xpath=//div[@class='current-quantity-text']    2

        #Decreasing Product Quantity
        Wait For And Click Element         xpath=//button[@class="qty-decrement"]
        
        #Verfying Product Quantity Decreased
        Wait For And Verify Content        xpath=//div[@class='current-quantity-text']    1

        #Checking Decrement Button Disabled
        Wait For And Verify Element        xpath=//button[@class='qty-decrement btnDisabled']       
        Checking "Add To Cart" UI
        
        # Checking Continue And Go To Cart Button
        # Disclaimer: Not Clicking Continue Button But  Checking It's Redirection By Href 
        Wait For And Verify Element        xpath=//div[@id="digi-cartpopup-ContinueShopping"]//a[@href="/shop/c/smartphones"]    #Testcase: 92590
        
        Redirection On Clicking            xpath=//div[@id="digi-cartpopup-GotoCart"]     https://www.jio.com/shop/cart     Shopping_cart
    END

Confirm the functionality of Click here text
    Sleep    1
    #Clicking on Click here
    Scroll To                                    //div[@class='prod-return-policy-link']//a
    # ${href_link}=    Get Element Attribute       //div[@class='prod-return-policy-link']//a    href
    # ${href_link}=    Fetch From Right    ${href_link}    :
    ${href_link}=   Set Variable     https://www.jio.com/jcms/en-in/rrl-policy/
    Wait For and Click Element                   //div[@class='prod-return-policy-link']//a
    
    #Switching to NEW Tab
    Switch Window   NEW

    #Validating Redirection
    ${url_validation}=    Get Location
    # ${url_validation}=    Fetch From Right    ${url_validation}    :
    Should Contain    ${url_validation}    ${href_link}

    #Closing NEW Tab and Switching to MAIN tab
    Close Window
    Switch Window    MAIN   

Open All Accordions                                   # Testcase:  92591,92593
    Checking Key features UI    ${Product_name+18}    # Test Case :92793,92594,92797,92798
    Checking "Technical Specifications"               # Test Case :92794,92595
    Checking "Shipping & Delivery"                    # Test Case :92795,92596
    Checking "Offers & Information"                   # Test Case :92796,92597,92799

Checking Key features UI
    [Arguments]    ${i}
    Scroll To    //a[@title="Key Features"]

    #Check whether accordion is expanded
    ${expanded} =    Get Element Attribute      //a[@title="Key Features"]    aria-expanded
    IF  "${expanded}" != "true"
        Wait For And Click Element              //a[@title="Key Features"]
    END
    Sleep    200ms   #Required Sleep 
    Element Attribute Value Should Be            //a[@title="Key Features"]    aria-expanded    true
    
    #Verify Content of Accordion
    Wait For And Verify Element                //div[@class="jio-pdp-key-new"]
    ${key_features} =    Get Element Count    //div[@class="key-feature-title"]
    FOR  ${key_feature}  IN RANGE    1    ${key_features+1}
        Scroll to                           (//div[@class="key-feature-title"])[${key_feature}]
        Wait For And Verify Element         (//div[@class="jio-pdp-key-new"]//div[contains(@style,"background-image")])[${key_feature}]
        Wait For And Verify Element              (//div[@class="key-feature-title"])[${key_feature}]
        #Checking Whether Tile contains Watch Section
        ${watch}=     Run Keyword And Return Status     Element Should Be Visible     (//div[@class="jio-pdp-key-new"])[${key_feature}]//div[@class='jio-watch']
        #Confirming Watch section UI
        IF   ${watch} == True
            
            #Checking Verifying Watch Button And Clicking
            Wait For And Verify Content     //div[@class='jio-watch']//span    Watch
            Wait For And Verify Element     //span[@class='jio-btn-watch']
            Wait For And Click Element      //div[@class='jio-watch']//span

            #Verifying Pop up
            Wait For And Verify Element     //div[@class='jio-pdp-video-content']

            #Closing Pop Up
            Wait For And Click Element      //div[@class='jio-popup-closebtn digi-stj-headmarg']//span
            
        END
        IF    "${sheet}" == "Shop_Accessories"
            ${links}=    Run Keyword And Return Status     Element Should Be Visible     (//div[@class="key-feature-description"])[${key_feature}]//a
            IF    ${links} == True
                
                ${Link_href}=    Get Element Attribute    xpath=(//div[@class="key-feature-description"])[${key_feature}]//a    href

                Wait For And Click Element                xpath=(//div[@class="key-feature-description"])[${key_feature}]//a
                
                #Switching to NEW Tab
                Switch Window   NEW


                #Validating Redirection
                ${Redirected_Tab}=    Get Location
                Should Be Equal    ${Redirected_Tab}    ${Link_href}

                #Closing NEW Tab and Switching to MAIN tab
                Close Window
                Switch Window    MAIN  
            END
        END
    END

    #Closing Accordion
    Scroll To                     xpath=//a[@title="Key Features"]
    Wait For And Click Element    xpath=//a[@title="Key Features"]
    #Checking Whether Accordion is Closed
    Wait For And Verify Element   xpath=//a[@title="Key Features" and @aria-expanded="false"]

Checking "Technical Specifications"
    Scroll To    //a[@id="tab-specification-link"]

    #Check whether accordion is expanded
    ${expanded} =    Get Element Attribute    //a[@id="tab-specification-link"]    aria-expanded
    IF  "${expanded}" != "true"
        Wait For And Click Element           //a[@id="tab-specification-link"]
    END
    Element Attribute Value Should Be           //a[@id="tab-specification-link"]    aria-expanded    true

    #Verify Content of Accordion
    Wait For And Verify Element             //table[@class="feature-class-table"]

    #Closing Accordion
    Scroll To                     xpath=//a[@id="tab-specification-link"]
    Wait For And Click Element    xpath=//a[@id="tab-specification-link"]
    #Checking Whether Accordion is Closed
    Wait For And Verify Element   xpath=//a[@id="tab-specification-link"and @aria-expanded="false"]

Checking "Shipping & Delivery"
    Scroll To    //a[@href="#tab-shipping"]

    #Check whether accordion is expanded
    ${expanded} =    Get Element Attribute    //a[@href="#tab-shipping"]    aria-expanded
    IF  "${expanded}" != "true"
        Wait For And Click Element            //a[@href="#tab-shipping"]
    END
    Element Attribute Value Should Be         //a[@href="#tab-shipping"]    aria-expanded    true

    #Verify Content of Accordion
    Wait For And Verify Content               //div[@id="tab-shipping"]     delivered within 3-5 business days    

    IF    "${sheet}" == "Shop_Accessories"
        
        
        ${link_presence}=    Run Keyword And Return Status    Wait For And Verify Element           xpath=//div[@id='tab-shipping']//div[@class='prod_content']//a
        IF    ${link_presence}
            ${Link_href}=    Get Element Attribute    xpath=//div[@id='tab-shipping']//div[@class='prod_content']//a    href

            Wait For And Click Element                xpath=//div[@id='tab-shipping']//div[@class='prod_content']//a
            
            ${windowhandles}=   Get Window Handles
            ${len}=  Get Length             ${windowhandles}
            
            IF    ${len} == 2
                #Switching to NEW Tab
                Switch Window   NEW


                #Validating Redirection
                ${Redirected_Tab}=    Get Location
                Should Be Equal    ${Redirected_Tab}    ${Link_href}

                #Closing NEW Tab and Switching to MAIN tab
                Close Window
                Switch Window    MAIN   

                #Closing Accordion
                Scroll To                     xpath=//a[@href="#tab-shipping"]
                Wait For And Click Element    xpath=//a[@href="#tab-shipping"]
                #Checking Whether Accordion is Closed
                Wait For And Verify Element   xpath=//a[@href="#tab-shipping"and @aria-expanded="false"]  
            ELSE
                #Validating Redirection
                ${Redirected_Tab}=    Get Location
                Should Be Equal    ${Redirected_Tab}    ${Link_href}
                Go Back
            END
        END

        
    END

Checking "Offers & Information"
    Scroll To    //a[@title="Offers & Information"]

    #Check whether accordion is expanded
    ${expanded} =    Get Element Attribute    //a[@title="Offers & Information"]    aria-expanded
    IF  "${expanded}" != "true"
        Wait For And Click Element           //a[@title="Offers & Information"]
    END
    Element Attribute Value Should Be        //a[@title="Offers & Information"]    aria-expanded    true

    #Verify Content of Accordion
    Wait For And Verify Content             //div[@id="tab-guarantees"]//strong    Warranty Period :-   
    
    #Link Redirection
    IF    "${sheet}" == "Shop_Accessories"
        ${Link_count}=  Get Element Count    //div[@id='tab-guarantees']//div[@class='prod_content']//a
        Log To console    ${Link_count}
        FOR    ${counter}    IN RANGE    1    ${Link_count+1}    
            Wait For And Verify Element               xpath=(//div[@id='tab-guarantees']//div[@class='prod_content']//a)[${Link_count}]
            ${Link_href}=    Get Element Attribute    xpath=(//div[@id='tab-guarantees']//div[@class='prod_content']//a)[${Link_count}]    href
            Wait For And Click Element                xpath=(//div[@id='tab-guarantees']//div[@class='prod_content']//a)[${Link_count}]
            ${windowhandles}=   Get Window Handles
            ${len}=  Get Length             ${windowhandles}
            
            IF    ${len} == 2
                #Switching to NEW Tab
                Switch Window   NEW

                #Validating Redirection
                ${Redirected_Tab}=    Get Location
                Should Be Equal    ${Redirected_Tab}    ${Link_href}
                Close Window
                Switch Window    MAIN   

                #Closing Accordion
                Scroll To                     xpath=//a[@title="Offers & Information"]
                Wait For And Click Element    xpath=//a[@title="Offers & Information"]
            
                #Checking Whether Accordion is Closed
                Wait For And Verify Element   xpath=//a[@title="Offers & Information"and @aria-expanded="false"] 
            ELSE
                ${Redirected_Tab}=    Get Location
                Should Be Equal    ${Redirected_Tab}    ${Link_href}
                Go Back
                Scroll To                     xpath=//a[@title="Offers & Information"]
                Wait For And Click Element    xpath=//a[@title="Offers & Information"]
            END
        END
    END
    
Checking Filter UI & Functionality
     # Clicking On Show Filters Option
    Click Show Filter Option
    # Verifying Cross Icon At Right Side             TestCase: 92712
    Wait For And Verify Element    xpath=//button[@class="close"]
    CSS Verification               xpath=//button[@class="close"]    Float    right  
    Wait For And Click Element     xpath=//button[@class="close"]
    #Clicking On Show Filters Option                Testcase: 92709,92697
    Click Show Filter Option
    # Subheading Filter
    Wait For And Verify Content    xpath=//span[@class="modal-title"]    Filters

    # Verifying Cancel Button
    Wait For And Verify Element    xpath=//button[@class="btn btn-default"]
    Text Verification              xpath=//button[@class="btn btn-default"]    Cancel

    # Verifying Apply Button
    Wait For And Verify Element    xpath=//button[@class="btn btn-primary"]
    Text Verification              xpath=//button[@class="btn btn-primary"]    Apply
    
    #Checking Filters UI                                Testcase: 92698,92599
    #Clicking Show more 
    @{show_more} =    Get WebElements    xpath=//div[@class="show-more-less show-more"]
    Log To Console        ${show_more}
    FOR  ${show}    IN    @{show_more}
        Scroll To    ${show}
        Wait For And Click Element    ${show}
    END    
    #Get Count Of No  Of Filters
    ${titles} =    Get Element Count      //div[@class="filter-title"]
    FOR  ${title}  IN RANGE    1    ${titles+1}
        #Reading Value from Excel
        ${title_data} =    Reading Data of Shops Page from Excel    ${title+1}    1    ${sheet}
        #Getting Value from Page
        Scroll To                       (//div[@class="filter-title"]/span)[${title}]
        Wait For And Verify Element     (//div[@class="filter-title"]/span)[${title}]
        ${title_name} =    Get Text         (//div[@class="filter-title"]/span)[${title}]
        Should Be Equal As Strings      ${title_data}    ${title_name}
        
        #Getting Type Of Filter
        ${type} =    Run Keyword And Return Status    Wait Until Page Contains Element    (//div[@class="filter-section"])[${title}]//label
        IF    "${type}" != "True"
            #Verify Slider functionality
            Selecting Slider value             (//div[@class="filter-section"])[${title}]//input    RANDOM
            Selecting Slider value             (//div[@class="filter-section"])[${title}]//input    MAX
        ELSE
            #Verify checkbox functionality        Testcase : 92776
            ${labels} =    Get Element Count    (//div[@class="filter-section"])[${title}]//label
            Reading Filter Option Data of Shop Page from Excel    ${title+1}    ${sheet}
            #Clicking on Checkbox button
            FOR    ${element}    IN    @{Opts}
                Check Checkbox Filter Option    ${title}    ${element}   
            END
                                           
        END      
    END
    
    #Verifying Apply Button of Filter Popup
    Wait For And Verify Element    //button[normalize-space()='Apply']

    #Verifying Cancel Button Of Filter Popup    Testcase: 92714
    Wait For And Verify Element    //button[normalize-space()='Cancel']

    Wait For And Click Element     //button[normalize-space()='Cancel']

Selecting Slider value
    [Arguments]    ${loc}    ${value}
    # It Selects The Minimum Value On The Slider
    IF  "${value}" == "MIN"
        Drag And Drop By Offset    ${loc}    -300    0

    # It Selects The Maximum Value On The Slider
    ELSE IF    "${value}" == "MAX"
        Drag And Drop By Offset    ${loc}    300    0

    # It Selects A Value At Random On The Slider
    ELSE
        ${random} =    Evaluate    random.randint(-299, 300)   random
        Sleep    200ms
        Drag And Drop By Offset    ${loc}    0    0        
    END

Check Checkbox Filter Option                                    #Testcase: 92699,92600
    [Arguments]    ${counter}    ${element}
    Scroll To           (//div[@class='filter-section'])[${counter}]//label[normalize-space()='${element}']//span
    #Verfying Checkbox UI and Functionality
    Check Checkbox      (//div[@class='filter-section'])[${counter}]//label[normalize-space()='${element}']//span
    Uncheck Checkbox    (//div[@class='filter-section'])[${counter}]//label[normalize-space()='${element}']//span

Click Show Filter Option
    #Verifying Whether Show Filter Option is visible            TestCase: 92708,92774,92598
    Wait For And Verify Element    //div[@class='filter-container']
    CSS Verification               //div[@class="filter-container"]    float     right
    Wait For And Click Element     //div[@class='filter-container']

Confirm product list is modified as per "Price filter"
    #Getting Number of Product after Applying Filter
    ${count_prod}=    Get Element Count    //div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container']

    #Iterating through Products And Verifying Whether it is According to Filter Applied 
    FOR    ${counter}    IN RANGE    1    ${count_prod+1} 
        
        Scroll To                          (//div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container'])[${counter}]//div[@class="pop-prod-desc mg-bt-0"]
        Wait For And Verify Element        (//div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container'])[${counter}]//div[@class="pop-prod-desc mg-bt-0"]

        #Getting Product Price
        ${price_prod}=    Get Text         (//div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container'])[${counter}]//div[@class="pop-prod-desc mg-bt-0"]

        #Cleaning price Text
        ${price_prod}=    Remove String    ${price_prod}    ,
        ${price_prod}=    Remove String    ${price_prod}    ₹

        #Converting Price Text to Integer 
        ${price_prod}=    Convert To Integer    ${price_prod}

        #Comparing Product Price to Filter Price
        IF    ${min_val_int}>${price_prod} or ${price_prod}>${max_val_int}
            FAIL
        END
    END

Confirm product list is modified as per "Brand filter"
    [Arguments]    ${brand}
    @{names} =    Get WebElements    //div[@class='col-lg-4 col-md-4 col-sm-6 col-xs-12 product-container']//div[@class="pop-prod-title"]/span
    FOR    ${i}    IN    @{names}
        Scroll To    ${i}
        Element Should Contain    ${i}    ${brand}    ignore_case= True
    END


Applying Slider Filter
    [Arguments]    ${loc}    ${slider_name}

    #Genrating Random Number For Filter Price Option
    #${random} =     Evaluate     random.randint(-300, 301)      random  

    #Verify Slider UI and functionality
    Wait For And Verify Content    ${loc}//div[@class="filter-title"]/span    ${slider_name}
    Wait For And Verify Element    ${loc}//div[@class="slider-container"]/input
    Wait For And Click Element     ${loc}//div[@class="slider-container"]/input

    #Selecting random Slider value
    Selecting Slider value         ${loc}//div[@class="slider-container"]/input    RANDOM
    
    #Getting Max Value
    ${max_val}=    Get Text        ${loc}//div[@class="slider-value"]/span

    #Getting Min Value
    ${min_val}=    Get Element Attribute        ${loc}//div[@class="slider-container"]/input    min

    # Removing "," From Max & Min Values And Converting Price Text To Integer
    ${max_val}=    Remove String             ${max_val}    ,
    ${min_val}=    Remove String             ${min_val}    ,
    ${max_val_int}=    Convert To Integer    ${max_val}
    ${min_val_int}=    Convert To Integer    ${min_val}
    Set Global Variable    ${max_val}        ${max_val}
    Set Global Variable    ${min_val}        ${min_val}
    Set Global Variable    ${max_val_int}    ${max_val_int}
    Set Global Variable    ${min_val_int}    ${min_val_int}

    #Clicking on Apply Button       Testcase: 92713
    Wait For And Click Element     //button[normalize-space()='Apply']

    #Verifying Tag is Present After Applying Filter
    Wait For And Verify Element    //a[@class='selected-filter-value']
    
    #Getting Text from Filter Tag
    ${filter_range}=    Get Text   //a[@class='selected-filter-value']//span

    #Comparing Tag Text with Applied Filter Values
    Should Contain     ${filter_range}    ${max_val}
    Should Contain     ${filter_range}    ${min_val}

Check Checkbox
    [Arguments]    ${loc}
    #Verify checkbox is selected 
    Wait For And Click Element    ${loc}
    CSS Verification    ${loc}    background-color    rgba(15, 60, 201, 1)
    
Uncheck Checkbox
    [Arguments]    ${loc}
    #Verify chcekbox is unselected    
    Wait For And Click Element    ${loc}
    CSS Verification    ${loc}    background-color    rgba(255, 255, 255, 1)


Verify Checkbox Filter
    [Arguments]    ${checkbox_value}
    #Verify brand filter is applied
    ${filter_value} =    Get Text    //a[@class="selected-filter-value"]
    #${filter_value} =     Convert To Lower Case    ${filter_value}
    Should Contain    ${filter_value}    ${checkbox_value}

Applying CheckBox Filter
    [Arguments]    ${loc}    ${filter_name}    ${checkbox_name}
    #Checking Filter Title
    Wait For And Verify Content    ${loc}//*[@class="filter-title"]/span    ${filter_name}

    #Clicking on Checkbox And Apply Button
    Scroll To    ${loc}//label[normalize-space()='${checkbox_name}']/span
    Check Checkbox    ${loc}//label[normalize-space()='${checkbox_name}']/span
    Wait For And Click Element    //button[@class="btn btn-primary"]


Remove Filter
    #verify removal of filters applied
    Scroll To    xpath=//a[@class="selected-filter-value"]
    ${filters} =    Get Element Count    xpath=//a[@class="selected-filter-value"]
    FOR  ${filter}  IN RANGE    1    ${filters+1}
        Wait For And Click Element       xpath=//a[@class="selected-filter-value"]
    END
    
    IF         '${sheet}' == 'Shop_Smartphone'
        URL Validation    https://www.jio.com/shop/en-in/c/smartphones?q=%3Arelevance
    ELSE IF    '${sheet}' == 'Shop_SmartDevices'
        URL Validation    https://www.jio.com/shop/en-in/c/smart-devices?q=%3Arelevance
    ELSE IF    '${sheet}' == 'Shop_Accessories'
        URL Validation    https://www.jio.com/shop/en-in/c/jioaccessories?q=%3Arelevance   
    ELSE
        URL Validation    https://www.jio.com/shop/en-in/c/jiofi?q=%3Arelevance   
    END

Element Verification
   [Arguments]       ${Button}          ${Sc_name}
    Scroll To                         ${Button}                 
    Wait For And Verify Element          ${Button}              
    Sleep     1s
    Take Page Screenshot                     ${Sc_name}
    #Go Back

Add to cart Button is disabled
    [Arguments]    ${Button}
    Scroll To    ${Button}
    Wait For And Verify Element    ${Button}
    Sleep     1s
    Element Should Be Disabled    ${Button}
    Log To Console    Button is Disabled

Enter Pin Code
    Scroll To    ${Button}
    
    #Checking If Button Is Disabled Or Not
    Element Should Be Disabled    ${Button}

    #Entering Pincode
    Wait For And Input Text       id:address.postcode    ${PIN_Code}

    #Button Click
    Wait For And Click Element    id:pincode-button
    
Stock Available
    # Checking Servicability Message
    Scroll To    //div[@class="availablity-msg"]/p
    #Getting The Text If Stock Available Or Not
    ${message}=    Get Text    xpath://div[@class="availablity-msg"]/p
    #Getting Only Status (Not Pincode)
    ${message}=    String.Split String    ${message}    for
    Log To Console    ${message}
    ${message}=    Set Variable    ${message[${0}]}
    # Checking Add To Cart Button Based On Availability Of Product
    IF  "${message}" == "Stock unavailable "   # Test Case : 92736   
        Element Should Be Disabled    ${button}
        Log To Console    Button is Disabled
        ${status}=    Set Variable    ${False}
    ELSE
        Element Should Be Enabled    ${button}
        Log To Console    Button is Enabled
        ${status}=    Set Variable    ${True}
    END
    [Return]    ${status}

Cross Button Functionality
   [Arguments]      ${locator}
    Wait For And Verify Element      ${locator}
    Sleep    100ms
    Wait For And Click Element       ${locator}
    Sleep    100ms

All Products Add to Cart Button Validation with PinCode
    Scroll to All Products
    ${number_products}=    Get Element Count    //div[contains(@class,"product-container")]
    Log To Console    ${number_products}
    Enter Pin Code
    Go Back
    FOR  ${i}  IN RANGE    ${number_products}
        Log To Console    ${i}
        Scroll To    (//div[contains(@class,"product-container")])[${i+1}]
        ${prod_name}=    Get Text    (//div[@class="pop-prod-title"]/span)[${i+1}]
        Wait For And Click Element    (//div[contains(@class,"product-container")])[${i+1}]
        Page Should Contain    ${prod_name}
        Element Verification    ${button}    SmartDevices_${i} 
        Stock Available
        Go Back
    END

Pop-Up UI content verification
    [Arguments]    ${status}=${True}
    #Verify the Message
    Wait For And Verify Content    //div[contains(@class,'digi-cartpopup-title')]    ${Pop_up[${0}]}
    #Verify the sub message based on redirection
    Wait For And Verify Content    //div[contains(@class,'digi-cartpopup-confirm')]    ${Pop_up[${1}]}
    #Go to cart button verification
    Wait For And Verify Content    id:digi-cartpopup-GotoCart    ${Pop_up[${2}]}
    #Continue shopping button verification
    Wait For And Verify Content    id:digi-cartpopup-ContinueShopping    ${Pop_up[${3}]}
    #Cross button verification
    Run Keyword If    ${status}    Cross Button Functionality    //div[@class="plp-brandpoupclosebt"]/div[contains(@class,'close-icon')]

Scroll to All Products
    #Navigating To All Products
    Scroll To                       //div[contains(@class," prod-title-wrap")]/span
    #Heading Verification
    Wait For And Verify Content    //div[contains(@class," prod-title-wrap")]/span      All Products

Pop-up button Verification
    Scroll to All Products

    #Getting Count Of Number Of Accessories Product Present
    ${number_products}=    Get Element Count    //div[contains(@class,"product-container")]
    Log To Console    ${number_products}

    #Iterating Through Each Products Available Inside All Products Category
    FOR  ${number_product}  IN RANGE    ${number_products}
        Log To Console    ${number_product}
        Scroll To                     (//div[contains(@class,"product-container")])[${number_product+1}]
        Wait For And Click Element    (//div[contains(@class,"product-container")])[${number_product+1}]
        # Checking Add to Cart Button                               Test Case : 92734
        Scroll To                      id:AddToCartBTN
        Wait For And Verify Element    id:AddToCartBTN
        Element Should Be Disabled     id:AddToCartBTN            # Test Case :  92735
        # Entering Pincode And Checking Its Functionality
        Enter Pin Code
        #Checking If That Product Is Available At That Pin Code
        ${Status}=   Stock Available
        IF  ${Status} == True
            #Checking If Pop-Up Has Two Buttons And They Are Redirecting Properly
            Pop-up button Redirection Validation
            #Clicking On Continue Shopping Button
            Continue Shopping button redirection and Validation            # Test Case : 92740
            Exit For Loop
        ELSE
            Go Back
            Log To Console    Product is unavailable
        END
        
    END


Pop-up button Redirection Validation
    # Adding Element To Cart And Then Validating UI Of Pop-Up
    Adding Product To Add To Cart Popup

    #Since This Site Is Unstable, This Is The Most Common Issue And Hence The Need To Add This Conditions
    ${status}=    Run Keyword And Return Status    Wait For And Verify Content    xpath=//div[contains(@class,'jio-empty-cart')]/div    Your shopping cart is empty.
    IF  ${status} == True
        # If After Clicking Add To Cart "Your Shopping Cart Is Empty" Heading Appear Then It Go Back And Try Again
        Log To Console    Site Error
        Go Back
        Pop-up button Redirection Validation
    ELSE
        #Cart Page UI Validation
        # !!!!!!  Page Revamped (It will get fail)  !!!!!!!
        Shopping Cart Page Validation                    # Test Case : 92739,92742
        Scroll To    ${button}
        Wait For And Click Element    ${button}
    END

Continue Shopping button redirection and Validation
    #Clicking on Continue Shopping Button
    Wait For And Click Element    id:digi-cartpopup-ContinueShopping    
    #Checking Redirection
    URL Validation    ${Shop_SubNavBar_URL[${1}]}    
    Take Page Screenshot    SmartPhones_page
    #Clicking Top Nav Cart Icon                Test Case : 92741
    Wait Until Element Is Visible            //div[@id="cart_nav_desktop"]/button[contains(@class,'j-button')]
    Wait For And Click Element               //div[@id="cart_nav_desktop"]/button[contains(@class,'j-button')]
    #Verfying Shopping Cart Heading
    Wait For And Verify Content              //div[contains(@class,'digi-cart-title')]                Shopping Cart 
    #Quantity to 0                           Test Case : 92745
    Update quantity to 0
    #Functionality of Bin Button             Test Case : 92746
    Click on Bin Button

Update quantity to 0   
    Log To Console    Updating item quantity to 0
    Wait For And Input Text    id:qty    0
    Wait For And Click Element     //a[contains(text(),'Update')]
    # Wait For And Verify Element    //div[@class="digi-popup"]
    Wait For And Verify Content    //div[contains(@class,'digi-cart-updatetext')]    Are you sure you want to remove the item from your cart?    
    Wait For And Click Element    //div[contains(@class,'digi-cart-cancelRemove')]

Click on Bin Button
    Sleep    1
    Log To Console    Clicking on Bin Icon
    Wait For And Click Element     //div[@class="j-listBlock__main txt-align--left l-breakpoint--desktop ml-auto cursor-pointer width-fit-content"]
    Wait For And Verify Content    //h2[@class="j-heading j-text-heading-s empty-cart-content line-height-1_25"]    Your shopping cart is empty
    
Promocode Validation 
    Log To Console    Operations on Promocode
    Wait For And Verify Element    //input[@placeholder="Have a promocode?"]
    Element Should Be Disabled    //button[@class="applycoupon-button promoApplyBtn"]
    Wait For And Input Text    //input[@placeholder="Have a promocode?"]    SDFasdf
    Element Should Be Enabled     //button[@class="applycoupon-button promoApplyBtn"]
    Wait For And Click Element     //button[@class="applycoupon-button promoApplyBtn"]
    Wait For And Verify Content    //div[@class="information_message negative"]/p    This voucher is invalid or has expired already.    

Product Details
    ${cost}    Get Text   xpath://span[@class="product-price"]
    ${value}    Replace String    ${cost[1:]}    ,    ${EMPTY}
    ${cost_int}    Convert To Integer    ${value}
    ${cost}=    Set Variable    ${cost[1:]}
    ${name}    Get Text    xpath://div[@class="header-emi-block"]/h2
    Log To Console    Name of Product us -${name}
    Log to console    Cost of Product is -${cost}

    ${product_details}=    Create List
    Append To List    ${product_details}    ${name}    ${cost}    ${cost_int}
    Log To Console    ${product_details}
    Set Global Variable    ${product_details}
    Scroll To    ${button}

Shopping Cart Page Validation
    # URL Validation 
    URL Validation                    https://www.jio.com/shop/cart
    #Title verification
    Wait For And Verify Content      //div[@class="j-text-heading-s"]    Shopping Cart  
    
    #Redirection in product Name                Test Case : 92743
    Wait For And Click Element       xpath=//div[@class='product-detail w-100']//a//div
    Wait For And Verify Content      xpath=//h2[@itemprop="name"]                                                 JioDive Smartphone based VR headset
    Go Back

    #Table column name verification
    FOR  ${i}  IN RANGE    1    5
        Wait For And Verify Content        (//tr[contains(@class,'cart-bundle-header')]/td)[${i}]    ${Table_Heading[${i-1}]}
        Log To Console    ${Table_Heading[${i-1}]} found
    END

    #Table row content verification
    ${prod_name}=    Get Text    (//div[contains(@class,'cart-productname')])[1]/a
    Log To Console    ${prod_name}
    IF  '${prod_name}' == '${product_details[${0}]}'
        Log To Console    Product Matched 
        Wait For And Click Element    (//div[contains(@class,'cart-productname')])[1]/a
        Page Should Contain    ${prod_name}
        Go Back
    END

    #Checking for Sub Total
    Log to Console    Sub Total: ₹ ${product_details[${1}]}
    Wait For And Verify Content    (//div[@class="j-text-body-m-bold j-color-primary-grey-100"])[1]    Sub Total: ₹ ${product_details[${1}]}
    
    #Checking for update button
    Wait For And Verify Element    //a[contains(text(),'Update')]
    Wait For And Input Text       id:qty    3
    Wait For And Click Element    //a[contains(text(),'Update')]
    Wait For And Verify Content   //div[@class="information_message positive"]/p    Product quantity has been updated.
    ${updated_value}=    Evaluate    ${product_details[${2}]}*${3}
    Log To Console    ${updated_value}
    # Wait For And Verify Content    //tbody/tr[4]/td[4]    Sub Total: ₹ ${product_details[${1}]*${3}}.00
    Page Should Contain    ${updated_value}

    #Checking for Cart Sumary heading
    Wait For And Verify Content    //div[contains(@class,'digi-cart-orderSummary')]/div[@class="title_holder clearfix"]/h2    Cart Summary
    #Product details
    Wait For And Verify Element    //div[contains(@class,'digi-cart-orderSummary')]/div[@class="item_container"]/table
    
    #Continue shopping button redirection                Test Case : 92749
    Wait For And Click Element    //a[@id="shpHide"]
    URL Validation    ${Shop_SubNavBar_URL[${1}]} 
    Go Back
    #Checkout button redirection                         Test Case : 92750
    Wait For And Click Element    id:checkoutButtonBottom
    URL Validation    ${PersonalDetails_Checkout_URL}
    Go Back

    #Promo code                    Test Case : 92747,92748
    Promocode Validation
    #Continue shoping button
    Wait for and Verify Element    id:shpHide
    #Checkout button
    Wait for and Verify Element    id:checkoutButtonBottom

    #Text in green
    Wait For And Verify Content    //div[@class="safe-text"]    Safe and Secure Payments. 100% authentic products. 
    CSS Verification    //div[@class="safe-text"]    color    rgba(26, 135, 60, 1)
    Log To Console    Done with Verification 
    Wait For And Click Element    (//div[contains(@class,'cart-productname')])[1]/a
    Page Should Contain    ${prod_name}

    Confirm the functionality and UI of Quantity & Add to cart            # Test Case : 92744

    Click on Bin Button

Filter on the bases of Price, Battery Capacity and Check "X" button functionality
    Filter Button    ${True}
    Filter Button    ${False}    ${True}
    Filter Button    ${False}    ${True}    ${True}

Filter Button
    [Arguments]    ${Price_Range_Filter}=${False}        ${Battery capacity_Filter}=${False}    ${Press_X_Button}=${False}

    #Checking if filter button is present or not
    Wait For And Verify Element    //div[contains(@class,"filter-container")]
    Log to Console    Filter button present

    #Clicking on Filter Button
    Wait For And Click Element    //div[contains(@class,"filter-container")]

    #Checking modal title
    Wait For And Verify Content    //span[@class="modal-title"]    Filters

    #Filter based on Price
    Run Keyword If    ${Price_Range_Filter}    Drag And Drop By Offset    id:priceRange    200    0
    Sleep    2

    #Filter based on battery Capcity
    Run Keyword If    ${Battery capacity_Filter}    Drag And Drop By Offset    id:batteryRange    -200    0
    Sleep    2
    
    #Cross Button functionality
    Run Keyword If    ${Press_X_Button}    Wait For And Click Element    //button[@class="close"]
    
    #Clicking Apply Buttton
    Run Keyword If    not ${Press_X_Button}     Wait For And Click Element    //button[contains(text(),'Apply')]

Personal Details Page
    Scroll to All Products
    #Getting count of number of elements present
    ${number_products}=    Get Element Count    //div[contains(@class,"product-container")]
    Log To Console    ${number_products}

    #Entering pin code 
    Enter Pin Code
    Go Back

    #Itterating through each products available inside all products category
    FOR  ${i}  IN RANGE    ${number_products}
        Log To Console    ${i}
        Scroll To    (//div[contains(@class,"product-container")])[${i+1}]
        Wait For And Click Element    (//div[contains(@class,"product-container")])[${i+1}]
        #Checking if that product is available at that pin code
        ${Status}=   Stock Available
        IF  ${Status} == True
            Adding Product To Add To Cart Popup
            ${status}=    Run Keyword And Return Status    Wait For And Verify Content    //div[contains(@class,'jio-empty-cart')]/div    Your shopping cart is empty.
            IF  ${status} == True
                Log To Console    Site error.
                Go Back
                Pop-up button Redirection Validation
            ELSE
                Log to Console    Inside Else 
                Checkout
            END
            Exit For Loop
        ELSE
            Go Back
            Log To Console    Product is unavailable
        END
        
    END

Adding Product To Add To Cart Popup
    #Checking Redirection To Particular Product Page And Product Content
    
    #  Getting Excel Details Of Product Detail
    Product Details

    #Clicking On Add To Cart Button 
    Wait For And Click Element     ${button}

    #Verify if pop-up is visible
    Wait For And Verify Element    //div[contains(@class,'digi-popup-subcontainer')]

    # Verify Add To Button UI            Testcase : 92738
    Checking "Add To Cart" UI

    # Product Has Been Added To Your Cart! Heading                 Test Case : 92737
    Wait For And Verify Content    xpath=//div[contains(@class,"cartpopup-title")]    Product has been added to your cart!
    # Add to cart popup subheading
    Wait For And Verify Content    xpath=//div[@class="digi-cartpopup-confirm mg-bt-16 mobile-body-s"]      ${Add_to_Cart_Question}
    #Redirection to Go to cart
    Wait For And Verify Content    id:digi-cartpopup-GotoCart    Go to Cart 
    Wait For And Click Element     id:digi-cartpopup-GotoCart 
    Sleep    200ms     # Required sleep

Checkout
    #Waiting untill Checkout button loads
    Wait Until Page Contains Element    id:checkoutButtonBottom    
    Wait for And Click Element          id:checkoutButtonBottom
    
    Personal details
    
Personal details 
    URL Validation    ${PersonalDetails_Checkout_URL}
    Personal Details Page Validation

Personal Details Page Validation
    [Arguments]    ${status}=${True}
    # Personal Details Page Heading "Enter Personal Details"
    Wait For And Verify Content    (//div[contains(@class,"title")]/h2)[1]    Enter personal details
    # Verifying Placeholder Of First Name, Last Name , Email Address And Mobile Number
    FOR  ${p_placeholder}  IN RANGE    1    5
        Element Attribute Value Should Be                     xpath=(//div[@class="formwidth"]/dd/input)[${p_placeholder}]    placeholder    ${Delivery_Data[${p_placeholder}]}   
    END

    #'Continue' Button Verification
    Wait For And Verify Content    personalDetailsContinueBtn    Continue
    CSS Verification    id:personalDetailsContinueBtn    background    rgb(0, 97, 195) none repeat scroll 0% 0% / auto padding-box border-box
    
    #Grey text verification
    ${count}=    Get Element Count    (//div[@class="item_container_holder"]/div)
    log to console    ${count}
    # Scrolling to 'If gifting, enter Giftee personal & delivery details.'
    Scroll To           (//div[@class="item_container_holder"]/div)[${count-1}]
    # Verifying 'If gifting, enter Giftee personal & delivery details.' text and its grey color 
    Wait For And Verify Element    (//div[@class="item_container_holder"]/div)[${count-1}] 
    CSS Verification    (//div[@class="item_container_holder"]/div)[${count-1}]    color    rgba(202, 202, 202, 1)
    # Verifying * Mandatory fields and its grey text color
    Wait For And Verify Element    (//div[@class="item_container_holder"]/div)[${count}]
    CSS Verification    (//div[@class="item_container_holder"]/div)[${count}]    color    rgba(202, 202, 202, 1)

    # Verifying Cart Summary Section            Test Case : 92752
    Run Keyword If    ${status}    Edit Button Redirection Checkout Page

    #Product details
    Wait For And Verify Element    //div[contains(@class,"digi-cart-orderSummary")]

Edit Button Redirection Checkout Page  
    # Verifying Cart Summary Section
    Wait For And Verify Content    (//div[contains(@class,"title")]/h2)[2]    Cart Summary
    # Checking Cart Summary Section Alignment On Page
    CSS Verification                //div[@class="cart-entries-totals digi-cart-OrdSumAlignmnt"]    float     right
    # Verifying Edit Button
    Wait For And Verify Content    id:editbtn    Edit
    # Clicking Edit Button And Checking Its Redirection
    Wait For And Click Element     id:editbtn
    URL Validation    ${Cart_URL}
    Go Back
    Sleep    200ms    #Sleep Required

Product Checkout Functionality
    # Scrolling to 'All Product' section
    Scroll to All Products
    #Getting Count Of Number Of Accessories Product Present
    ${number_products}=    Get Element Count    //div[contains(@class,"product-container")]
    Log To Console    ${number_products}

    #Iterating Through Each Products Available Inside All Products Category
    FOR  ${number_product}  IN RANGE    1    ${number_products}
        Log To Console    ${number_product}
        
        Wait For And Click Element    (//div[contains(@class,"product-container")])[${number_product}]

        #Entering pin code 
        Enter Pin Code
        #Checking If That Product Is Available At That Pin Code
        ${Status}=   Stock Available
        IF  ${Status} == True
            Scroll To             xpath=//div[@class="prod-return-policy-text"]
            Wait For And Click Element    ${button}
            Verifying Content & Redirection Of Popup Functionality
            Personal Details Page Functionality            # Test Case : 92751,92753
            Delivery Address Page Functionality            # Test Case : 92754
            Payment Method Page Functionality              # Test Case : 92757,92758,92759
            Exit For Loop
        ELSE
            Go Back
            Log To Console    Product is unavailable
        END
        
    END

Verifying Content & Redirection Of Popup Functionality
    # Verifying Content of Popup  after Clicking Add to Cart Button
    Take Page Screenshot   ProductAdded_Popup 
    Wait For And Verify Content    xpath=//div[contains(@class,"cartpopup-title")]    Product has been added to your cart!
    
    # Clicking Go To Cart Button
    Wait For And Verify Content    xpath=//div[@id="digi-cartpopup-GotoCart"]    Go to Cart
    Wait For And Click Element     xpath=//div[@id="digi-cartpopup-GotoCart"]
    
    # Redirected to Shop Cart Page
    URL Validation    https://www.jio.com/shop/cart
    
    # Shopping Cart Button
    Wait For And Verify Content    xpath=//div[@class='j-text-heading-s']    Shopping Cart
    
    # Clicking Checkout Button and Redirected to Personal Details Page
    Wait For And Click Element    xpath=//button[@class='j-button j-button-size__large primary primary-bg width-100pc']

Personal Details Page Functionality
    #UI validation of Pesonal Details Page
    Personal Details Page Validation

    #Error Validation
    Error message in Personal Details Page
    # Checkout Page URL Validation
    URL Validation            ${PersonalDetails_Checkout_URL}
    
    # Entering First Name
    Wait For And Input Text    xpath=//input[@id="personalDetail.firstName"]    MS
    # Entering Last Name
    Wait For And Input Text    xpath=//input[@id="personalDetail.lastName"]    Dhoni
    # Entering Email Address
    Wait For And Input Text    xpath=//input[@id="personalDetail.emailAddress"]    akcricketer@gmail.com
    # Entering Mobile Number
    Wait For And Input Text    xpath=//input[@id="personalDetail.mobileNumber"]   ${Incorrect_No2}
    # !!!!!!!!!!Due To Site Changes On The Product Wifi Mesh In Personal Details Page, Code Below Might Be Required !!!!!!!
    # ${status}=    Run Keyword And Return Status    Wait For And Verify Content     xpath=//a[contains(text(),'WiFi Mesh Extender JCM0112')]     WiFi Mesh Extender JCM0112
    # IF    ${status}   
    #     Wifi Mesh Condition
    # END
    # Click Continue Button
    Wait For And Verify Element    xpath=//button[@id="personalDetailsContinueBtn"]
    Wait For And Click Element     xpath=//button[@id="personalDetailsContinueBtn"]

Wifi Mesh Condition
    #Checking if Wifi Mesh is present or not 
    Wait For And Verify Content     xpath=//a[contains(text(),'WiFi Mesh Extender JCM0112')]     WiFi Mesh Extender JCM0112 
    Select From List By Index     id:personalDetail.extenderRouterModel     2

Error message in Personal Details Page
    # Click Continue Button
    Wait For And Click Element     xpath=//button[@id="personalDetailsContinueBtn"]

    #Title verification
    Wait For And Verify Content    xpath=//div[@class="title_holder"]/h2    Enter personal details   

    #UI validation of error message
    Wait For And Verify Content    xpath=//p[contains(text(),'Errors were found with the details provided. Please check the errors below and re-submit your details.')]    ${Error_Message}[0]
    CSS Verification               xpath=//div[@class="information_message negative"]    background-color     rgba(199, 23, 32, 1)
    
    #Text validation of each field
    FOR  ${i}  IN RANGE    1    4
        CSS Verification    (//div[@class="formwidth"]/span/p/span)[${i}]    color    rgba(217, 38, 42, 1)
        Wait For And Verify Content    (//div[@class="formwidth"]/span/p/span)[${i}]    ${Error_Text[${i}]}
    END
    Log to console    Error Messages validated

Error message in Delivery Details Page_1
    # Click Continue Button
    Wait For And Click Element     xpath=//button[contains(text(),"Continue")]

    #Title verification
    Wait For And Verify Content    xpath=//div[@class="title_holder"]/h2    Enter your address   

    #UI validation of error message
    Wait For And Verify Content    xpath=//p[contains(text(),'Errors were found with the address you provided. Please check the errors below and re-submit your address.')]    ${Error_Message_1}[0]
    CSS Verification               xpath=//div[@class="information_message negative"]    background-color     rgba(199, 23, 32, 1)
    
    #Text validation of each field
    FOR  ${i}  IN RANGE    1    4
        CSS Verification    (//div[@class="formwidth"]/span/p/span)[${i}]    color    rgba(217, 38, 42, 1)
        Wait For And Verify Content    (//div[@class="formwidth"]/span/p/span)[${i}]    ${Error_Text_1[${i}]}
    END
    Log to console    Error Messages validated

Delivery Address Page Functionality
    # Redirected To Delivery Address Page
    URL Validation    ${DeliveryDetails_Checkout_URL}

    UI Validation of Delivery Address Page

    # Click on edit button beside Personal details         Test Case : 92755
    Wait For And Click Element    xpath=//a[@class="right digi-hover"]
    # Checking redirection to personal details page
    URL Validation    ${PersonalDetails_Checkout_URL}
    # Click on Continue Button in personal page
    Wait For And Click Element    xpath=//button[@id="personalDetailsContinueBtn"]
    
    # Click Continue Button In Delivery Page Without Entering Details        Test Case : 92756 
    Error message in Delivery Details Page_1

    # Entering
     # Address Line 1
    Wait For And Input Text      xpath=//input[@id="address.line1"]    House No.2
     #Address Line 2
     Wait For And Input Text     xpath=//input[@id="address.line2"]    Valmiki Building
     #Address Line 3
     Wait For And Input Text     xpath=//input[@id="address.area.locality"]    Pump House
    
    # Click Continue Button 
    Wait For And Click Element   xpath=//button[@class="positive"]

UI Validation of Delivery Address Page
    # Validating Content 
    Wait For And Verify Content                               xpath=//div[@class="title_holder"]/h2    ${Delivery_Data[${0}]}
    # Verifying Tick Mark in Personal Details
    Wait For And Verify Element                               xpath=//span[@class="digi-tick-img digi-tick-enabled"]
    # Verifying Placeholder
    FOR  ${placeholder}  IN RANGE    1    4
        #Validating Address lines
        Element Attribute Value Should Be                     xpath=(//div[@class="formwidth"]/dd/input)[${placeholder}]    placeholder    ${Delivery_Address[${placeholder}]}   
    END
    
    #Validating Pincode
    Wait For And Verify Element                               xpath=(//div[@class="formwidth"]/dd/input)[4]        
    ${Fetching_Pincode}=                                      Execute Javascript    return document.getElementById("address.postcode").value
    Log to Console    ${Fetching_Pincode}
    Should Be Equal As Strings    ${Fetching_Pincode}    ${PIN_Code}    Pincode Found    
    
    #Validating City, State and Country
    Wait For And Verify Element                               id:address.districtCity
    Wait For And Verify Element                               id:address.state      
    Wait Until Page Contains                                  India      
    Log to Console                                            UI validation of Address Page completed 

Payment Method Page Functionality
    # Checking UI of Payment Method Page
    Payment Page UI
    # Clicking Proceed to payment button with checking the checkbox
    Wait For And Click Element    xpath=//label[@onclick="upiRadioButtonValidation()"]
    Wait For And Click Element    xpath=//button[@id="upiButton"] 
    Sleep    300ms                # Required Sleep
    URL Validation                https://www.billdesk.com/bankservices/UPIController?  
    Sleep    200ms         


    #Payment Method & Functionality
    ${Payment_Method_Count}=     Get Element Count                           xpath=//a[@class="digi-payment-anchor"]
    Log To Console    ${Payment_Method_Count}
    FOR  ${Payment_Method}  IN RANGE  1    ${Payment_Method_Count+1}
    
        ${Terms}=    Run Keyword And Return Status            Wait For And Verify Element                    xpath=//div[contains(text(),"Select Payment Option")]
        #Clicking on each payment option
        Wait For And Click Element                            xpath=(//a[@class="digi-payment-anchor"])[${Payment_Method}]
        # Verifying content of each payment method
        Wait For And Verify Element                           xpath=//div[contains(@class,"payment-detailsTab")]
        IF    ${Terms}== True
            # Terms & Conditions into view
            Scroll To                                         xpath=(//span[@class="digi-terms"])[${Payment_Method}]
            # Clicking on Terms & Conditions
            Wait For And Click Element                        xpath=(//span[@class="digi-terms"])[${Payment_Method}]
            Switch Window                                    NEW
            # Verifying the URL of Terms & Conditions Page
            URL Validation                                    https://www.jio.com/en-in/online-terms
            Close Window                                      
            # Changing tab to payment gatway tab
            Switch Window                                        MAIN 
        END
    END

Payment Page UI
    # 'Select Payment Option' heading
    Wait For And Verify Element    xpath=//div[contains(@class,"digi-payment-paymentmethod panel ")]//div[@class="digi-payment-paymentopthead"]
    #  T&C text
    Wait For And Verify Element    xpath=//div[contains(@class,'digi-payment-paymentmethod panel ')]//span[contains(text(),"I agree with the")]
    # T&C link
    Wait For And Verify Element    xpath=//div[contains(@class,'digi-payment-paymentmethod panel ')]//div[@class='digi-payment-termsconditions']//a
    # T&C Checkbox
    Wait For And Verify Element    xpath=//label[@onclick="upiRadioButtonValidation()"]
    # Table on the left with Payment Options:
    CSS Verification    xpath=//div[@class="digi-payment-paymentoptionstab payment-optionsTab"]    float    left
    Wait For And Verify Element    xpath=//div[@class="digi-payment-paymentoptionstab payment-optionsTab"]
    ${Payment_Method_Count}=     Get Element Count                           xpath=//a[@class="digi-payment-anchor"]
    Log To Console    ${Payment_Method_Count}
    FOR  ${Payment_Method}  IN RANGE  0    ${Payment_Method_Count}
        #Verifying on each payment option
        Wait For And Verify Content                            xpath=(//a[@class="digi-payment-anchor"])[${Payment_Method+1}]        ${Payment_method_name}[${Payment_Method}]
    END
    # Verifying Summary Cart
    Wait For And Verify Element    xpath=//div[@class="item_container_holder digi-cart-orderSummary"]
    # Personal Details
    Scroll To                      xpath=(//div[@class="span-6 checkout_multi_a complete last right"])[1]
    Wait For And Verify Element    xpath=(//div[@class="span-6 checkout_multi_a complete last right"])[1]
    # Delivery Address
    Scroll To                      xpath=(//div[@class="span-6 checkout_multi_a complete last right"])[2]
    Wait For And Verify Element    xpath=(//div[@class="span-6 checkout_multi_a complete last right"])[2]
    # Proceed to payment button
    Scroll To                      xpath=//button[@id="upiButton"]
    Wait For And Verify Element    xpath=//button[@id="upiButton"]
    # Clicking Proceed to payment button without checking the checkbox
    Wait For And Click Element    xpath=//button[@id="upiButton"]
    # Error Message "Please agree with terms and conditions before proceeding the payment" in red color 
    Wait For And Verify Content    xpath=//div[@id="upiTerms"]    Please agree with terms and conditions before proceeding the payment
    CSS Verification    xpath=//div[@id="upiTerms"]    color    rgba(255, 0, 0, 1)

# ------------------------------- APPS --------------------------#

Tile Verification    
    IF         "${App_name}" == "MyJio"
        #Backgroud Wait For And Verify Element
        Wait For And Verify Element                            xpath=//div[@class="j-card css-1hcx8jb"]//section[@class="j-container l-layout--flex"]//img
        #App Tiles Logo Verification
        Wait For And Verify Element                            xpath=//div[@class="css-1viv00l"]//div[@class="j-listBlock__main"]//img
        #Title Verification Heading
        Text Verification                             xpath=//div[@class="j-contentBlock__title"]//h3                    Here's how India got a first taste of a super app
        #App Tiles Title Verification
        Text Verification                             xpath=//span[normalize-space()='${App_name}']        ${App_name}
        #App Tiles Subtitle Verification
        Text Verification                             xpath=//div[@class="j-contentBlock__description"]//div[@class="j-text j-text-body-m"]               ${Subtitle} 
        #App Tiles Text Verification
        Text Verification                             xpath=//span[normalize-space()='${App_name}']        ${App_name}
        #App Tiles Get Now Button Verification
        Text Verification                             xpath=//div[@class="css-1viv00l"]//div[@class="j-button-group"]//button[1]         Get Now
        #App Tiles Know More Button verification
        Text Verification                             xpath=//div[@class="css-1viv00l"]//div[@class="j-button-group"]//button[2]      ${Button_2}
    ELSE
        #Backgroud Wait For And Verify Element
        Wait For And Verify Element                            xpath=//div[@aria-label="${App_name}"]//div[@class="j-card__image ratio-wide"]//img
        #App Tiles Logo Verification
        Wait For And Verify Element                            xpath=//div[@aria-label="${App_name}"]//div[@class="j-listBlock__main"]//img
        #App Tiles Title Verification
        Text Verification                             xpath=//span[normalize-space()='${App_name}']        ${App_name}
        #App Tiles Subtitle Verification
        Text Verification                             xpath=//div[@aria-label="${App_name}"]//div[@class="j-contentBlock__description"]        ${Subtitle}
        #App Tiles Get Now Button Verification
        #JioPOS Lite Should throw error
        Text Verification                             xpath=//div[@aria-label="${App_name}"]//div[@class="j-button-group"]//button[1]           Get Now
        #App Tiles Know More Button verification
        Text Verification                             xpath=//div[@aria-label="${App_name}"]//div[@class="j-button-group"]//button[2]           ${Button_2}
    END
    


Popup Content Verification
    #Verifies the content of Pop Up    
    Text Verification                                           xpath=//section[@class="j-container l-layout--centered"]//h5[@cLass="j-heading j-text-heading-xs"]                     This app is not available for your device
    Text Verification                                           xpath=//div[@class='j-text j-text-body-xs']                             Available only in
    
    ${elements}=                   Get WebElements              xpath=//div[@class="j-modal-content"]//img
    FOR  ${element}  IN  @{elements}
        Wait For And Verify Element                             ${element}     
    END
  
 
Infographics Verificationn
    # ${count}=     Set Variable  0
    #Stores the infographic's titles into a list
    ${elements_title}=  Get WebElements   xpath=//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__title"]    
    ${length_title}=    Get Length       ${elements_title}
    # #Text Verification For Title. This compares the list with excel values
    
    # #Text Verification For Title
    # FOR  ${title}  IN  @{elements_title}
    #             Text Verification           ${title}       ${Infographics}[${count}] 
    #             ${count}=   Evaluate     ${count} + 1
    # END
    
    # ${count}=     Set Variable  0
    # #Stores the infographic's subtitles into a list
    # ${elements_subtitle}=  Get WebElements   xpath=//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__description"]
   
    # #Text Verification For Subtitle. This compares the list with excel values
    # FOR  ${subtitle}  IN  @{elements_subtitle}
    #             Text Verification           ${subtitle}       ${Infographics_subtitle}[${count}]
    #             ${count}=   Evaluate     ${count} + 1
    # END

    # #Wait For And Verify Element of Infographics 
    # FOR  ${image}  IN RANGE    1   ${length_title} + 1
    #         Scroll To                 xpath=(//div[@class="j-card__image ratio-landscape"])[${image}]
    #         Wait For And Verify Element           xpath=(//div[@class="j-card__image ratio-landscape"])[${image}]/img
    # END

    #Verifying Title is Bold and Subtext is of Lighter Font. Checks for the required CSS attribute
    FOR  ${check_text}  IN RANGE    1   ${length_title} + 1
            CSS Verification        xpath=(//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__title"]//h3)[${check_text}]        font-weight        900
            CSS Verification        xpath=(//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__description"]//div)[${check_text}]        font-weight        500
    END

    #Images are in alternate positions. The loop is iterating for all the sections in infographics
    FOR  ${it}  IN RANGE    1   ${length_title} + 1
        ${val}=     Set Variable        ${2}
        ${zero}=    Set Variable        ${0}
        ${modulo_result}    Evaluate    ${it}%${val}
        # If the image is on the left side or right side the following if else loop checks for the attribute order.
        IF     ${modulo_result} == ${zero}
            IF  "${App_name}" == "JioMart"
                    CSS Verification      xpath://div[@class="j-card size--xs card-vertical no-top-padding no-bottom-padding j-card__shadow"]/ancestor::section[@data-testid="app-features-section"]/div[${it}]/div[1]        order        1
            ELSE
                    CSS Verification      xpath://div[@class="j-card size--xs card-vertical no-top-padding no-bottom-padding j-card__shadow"]/ancestor::section[@data-testid="app-features-section"]/div[${it}]/div[1]        order        2
            END
        ELSE
            IF  "${App_name}" == "JioMart"
                    CSS Verification      xpath://div[@class="j-card size--xs card-vertical no-top-padding no-bottom-padding j-card__shadow"]/ancestor::section[@data-testid="app-features-section"]/div[${it}]/div[1]         order        2
            ELSE
                    CSS Verification      xpath://div[@class="j-card size--xs card-vertical no-top-padding no-bottom-padding j-card__shadow"]/ancestor::section[@data-testid="app-features-section"]/div[${it}]/div[1]         order        1
            END
        END
    END

    # #Checking for infographics button
    # ${count}=     Set Variable  0
    # ${Infographics_Button_Presense}=      Run Keyword And Return Status   Element Should Be Visible   xpath=//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__children"]      
    # IF  ${Infographics_Button_Presense} == True
    #     ${elements_button}=  Get WebElements   xpath=//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__children"]    
    #     # Following loop checks the text of all the buttons if present in the infographics section
    #     FOR  ${button}  IN  @{elements_button}
    #                 Text Verification           ${button}       ${Infographics_button}[${count}] 
    #                 ${count}=   Evaluate     ${count} + 1
    #     END
    # END
    
    #Checking for infographics caption
    ${count}=     Set Variable  0
    ${Infographics_Caption_Presense}=      Run Keyword And Return Status   Element Should Be Visible   xpath=//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__caption"]  
    IF  ${Infographics_Caption_Presense} == True
        ${elements_caption}=  Get WebElements   xpath=//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__caption"] 
        #Text Verification For Caption
        FOR  ${caption}  IN  @{elements_caption}
                    Text Verification           ${caption}       ${Infographics_caption}[${count}] 
                    ${count}=   Evaluate     ${count} + 1
                    #This is to verify that the captions present in JioMart is of blue color but is not automatable as there is no CSS attribute to verify. If any attribute found add it below
                    # IF  "${App_name}" == "JioMart"
                    #         CSS Verification        (//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__caption"])[${count}]            color        rgba(0, 0, 0, 0)
                    # END         
        END
    END

    #Checking for infographics Links
    Reload Page 
    ${Infographics_Link_Presense}=      Run Keyword And Return Status   Element Should Be Visible   xpath=//section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__description"]//a
    IF  ${Infographics_Link_Presense} == True
        Wait For And Verify Element                xpath://section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__description"]//a  
        ${Link_name}=    Get WebElement    xpath://section[@data-testid="app-features-section"]//div[@class="j-grid"]//div[@class="j-contentBlock__description"]//a  
        Text Verification        ${Link_name}        ${InfoGraphicsLinks}
        IF  "${App_name}" == "JioChat"
                Wait For And Click Element         xpath=//a[ normalize-space()='${InfoGraphicsLinks}']
                Take Page Screenshot               Mail_App     
                #It open's up the mail App which does not close.  
                #Wait For And Click Element         xpath=//span[ @class='l-breakpoint--widescreen sp--xxl pd--all j-Space__horizontal j-Space']
        ELSE
                Redirection On Clicking            xpath=//a[normalize-space()='${InfoGraphicsLinks}']  ${Infographics_URL}   ${App_name}_InfoGraphicsLink
        END
    END

Click Get Now Button
    [Arguments]    ${Carousel_button}=${NONE}
    Log to Console    ${App_name}
    IF    "${App_name}" == "JioMeet" or "${App_name}" == "JioHome"
        #Set Selenium Speed                                      100ms 
        # This Loop is present because both of these apps does not open a popup    
        Wait For And Click Element                                  xpath=//div[@aria-label="${App_name}"]//div[@class="j-button-group"]//button[1]   
    ELSE    
        #Set Selenium Speed                                      100ms     
        IF         "${App_name}" == "MyJio"
            Wait For And Click Element                              xpath=//div[@class="css-1viv00l"]//div[@class="j-button-group"]//button[1]
            #Passes the xpath of get now button on which it clicked to download page redirection
            Download Page Redirection                               //div[@class="css-1viv00l"]//div[@class="j-button-group"]//button[1]
        ELSE
            Wait For And Click Element                              xpath=//div[@aria-label="${App_name}"]//div[@class="j-button-group"]//button[1]   
            #IF it's not None
            IF    "${Carousel_button}" 
                #Passes the xpath of get now button on which it clicked and Value of Carousel Button if present to download page redirection
                Download Page Redirection                           //div[@aria-label="${App_name}"]//div[@class="j-button-group"]//button[1]                ${Carousel_button}     
            ELSE
                #Passes the xpath of get now button on which it clicked to download page redirection
                Download Page Redirection                           //div[@aria-label="${App_name}"]//div[@class="j-button-group"]//button[1] 
            END
        
        END
        #Closes the popup
        Click Close Button
    END
    

Download Page Redirection
    [Arguments]        ${Get_Now_Path}                      ${Carousel_Button}=${NONE}         
    ${elements}=  Get WebElements                           xpath=//div[@class="j-modal-content"]//img
    #Finds how many buttons are there in the Popup
    ${length of elements}=                                  Get Length           ${elements}
    #Following Loop does the following operations for the number of buttons it has. i.e Playstore, Appstore, Go to Website
    # 1. Clicks the button -> Validates URL-> Takes Screenshot -> Goes back -> Clicks again
    # If Carousel is present for the app, it clicks the carousel button
    IF  ${length of elements} == 2
            Popup Content Verification 
            Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore
            Wait For And Click Element                          xpath=${Get_Now_Path}
            Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/AppStore.png"]    ${POPUP_URL}[1]    ${App_name}_AppStore                     
            Wait For And Click Element                          xpath=${Get_Now_Path}     
    
    ELSE IF   ${length of elements} == 3
            Popup Content Verification 
            Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore

                IF  ${Carousel_Button}
                    Wait For And Click Element                      xpath=(//ul[@class="react-multi-carousel-dot-list "]//li)[${Carousel_Button}]
                END

            Wait For And Click Element                          xpath=${Get_Now_Path}
            Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/AppStore.png"]    ${POPUP_URL}[1]    ${App_name}_AppStore   

                IF  ${Carousel_Button}
                    Wait For And Click Element                      xpath=(//ul[@class="react-multi-carousel-dot-list "]//li)[${Carousel_Button}]
                END

            Wait For And Click Element                          xpath=${Get_Now_Path}
            Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/GoToWebsite.png"]    ${POPUP_URL}[2]    ${App_name}_Website  
                IF  ${Carousel_Button}
                    Wait For And Click Element                  xpath=(//ul[@class="react-multi-carousel-dot-list "]//li)[${Carousel_Button}]
                END
            Wait For And Click Element                          xpath=${Get_Now_Path}

    #---- FOLLOWING MUST BE UNCOMMENTED WHEN CAROUSAL APPEARS ON COMMUNICATIONS TAB-----
    
    # ELSE IF     "${App_name}" == "JioCall"
    #         Wait For And Click Element                          xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]   
    #         Verify Apps Page Loaded                                  ${App_name}
    #         URL Validation                                      ${POPUP_URL}
    #         Take Page Screenshot                                ${App_name}_PlayStore
    #         Go Back
    #         Wait for and click element                          xpath=(//span[@class="inactive"])[3]
    #         Wait For And Click Element                          xpath=(//button[@class="j-button j-button-size__medium primary"])[${index}]  
    
    ELSE
            Popup Content Verification 
            Redirection On Clicking                               xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore
            IF         "${App_name}" == "JioCall"
                Wait For And Click Element                        xpath=//section[@aria-label='apps for category Communication']//ul[@class="react-multi-carousel-dot-list "]//li[2]
                Wait For And Click Element                        xpath=${Get_Now_Path}      
            ELSE
                Wait For And Click Element                        xpath=${Get_Now_Path}
            END
    END


Banner Verification
    #This Keyword Clicks the Banner
    IF    "${App_name}" == "JioMeet" or "${App_name}" == "JioHome"
        #Set Selenium Speed                                      100ms     
        Wait For And Click Element                              xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']
        # Set File Path                                           C:\Users\Jay.Chaudhari\Downloads\JioMeetSetup.exe
        # File Should Exist                                       JioMeetSetup.exe
        # Click Close Button
    # ELSE IF    "${App_name}" == "JioHome"
    #     Set Selenium Speed                                      100ms     
    #     Wait For And Click Element                              xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']
    ELSE    
        Wait For And Click Element                 xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']
        Popup Content Verification
        Redirection for banner
        Click Close Button
    END

Redirection for banner
    ${elements}=  Get WebElements                           xpath=//div[@class="j-modal-content"]//img
    #Finds how many buttons are there in the Popup
    ${length of elements}=                                  Get Length           ${elements}
    #Following Loop does the following operations for the number of buttons it has. i.e Playstore, Appstore, Go to Website
    # 1. Clicks the Banner -> Validates URL-> Takes Screenshot -> Goes back -> Clicks again
    IF  ${length of elements} == 2
            Redirection On Clicking                               xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore
            Wait For And Click Element                          xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children'] 
            Redirection On Clicking                               xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/AppStore.png"]    ${POPUP_URL}[1]    ${App_name}_AppStore                       
            Wait For And Click Element                          xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']
    ELSE IF   ${length of elements} == 3 
            Redirection On Clicking                               xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore
            Wait For And Click Element                          xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']
            Redirection On Clicking                               xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/AppStore.png"]    ${POPUP_URL}[1]    ${App_name}_AppStore
            Wait For And Click Element                          xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']
            Redirection On Clicking                               xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/GoToWebsite.png"]    ${POPUP_URL}[2]    ${App_name}_Website  
            Wait For And Click Element                          xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']  
    ELSE
            Redirection On Clicking                               xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore
            Wait For And Click Element                          xpath=//div[@class='j-promo-card bg--primary img--filled orientation--horizontal no-children']
    END

Click Close Button
    #Verifies and Clicks the X button in Popups
    Wait For And Verify Element                                 xpath=//button[@class='j-button j-button-size__medium tertiary icon-primary icon-only']
    Wait For And Click Element                                  xpath=//button[@class='j-button j-button-size__medium tertiary icon-primary icon-only']

Content Validation
    # Scrolls to Top getnow Button
    Scroll To                                 xpath=//button[@class="j-button j-button-size__medium primary"]
    

    #Following IF loop validates Logo,App name and their subtitles(Top Text) for various apps for top get now button and bottom get bow button (if present).
    ${temp}=       Convert To Lower Case    ${App_name}
        #Following IF loop validates Logo,App name and their subtitles For (Top Text) and (Bottom Text) for various apps.
    IF    "${App_name}" == "JioGames"
        #Top Get Now Header
        Logo Verification                     xpath=//section[@data-testid="get-now-top-header"]//img
        Text Verification                     xpath=//section[@data-testid="get-now-top-header"]//div[@class="j-heading j-text-heading-xs"]                   ${App_name}
        Text Verification                     xpath=//section[@data-testid="get-now-top-header"]//h2                      ${TopText}
    ELSE
        #Top Get Now Header
        Logo Verification                     xpath=//section[@data-testid="get-now-top-header"]//img
        Text Verification                     xpath=//section[@data-testid="get-now-top-header"]//div[@class="j-heading j-text-heading-xs"]                   ${App_name}
        Text Verification                     xpath=//section[@data-testid="get-now-top-header"]//h2                                                          ${TopText}
            
        #Bottom Get Now Header
        Logo Verification                     xpath=//section[@class="css-1x6are8 j-container"]//img
        Text Verification                     xpath=//section[@class="css-1x6are8 j-container"]//h2                      ${App_name}
        Text Verification                     xpath=//section[@class="css-1x6are8 j-container"]//h3                     ${BottomText}
          
    END
   
    #Following IF loop validates Smart Features ,Testimonials and FAQ sections for various apps.  
   IF    "${App_name}" == "MyJio" or "${App_name}" == "JioTV" or "${App_name}" == "JioCinema" or "${App_name}" == "JioHealthHub" or "${App_name}" == "JioChat" or "${App_name}" == "JioSecurity" or "${App_name}" == "JioPages"
       Smart Features Verification
       Testimonials Verification
       Apps FAQ Verification
     
   ELSE IF  "${App_name}" == "JioMart" or "${App_name}" == "JioPOS Lite" or "${App_name}" == "JioCall" or "${App_name}" == "JioGames" or "${App_name}" == "JioCloud" or "${App_name}" == "JioHome"
       Apps FAQ Verification
        IF    "${App_name}" == "JioMart" or "${App_name}" == "JioCloud"
           Testimonials Verification
        ELSE
            Smart Features Verification
        END   
    ELSE     
       Apps FAQ Verification
    END


All Get Now Verification of App Information Page
    #All Buttons Verification 
    ${count}=                   Set Variable                    0
    ${elements}=                Get WebElements                 xpath=//div[@class="j-contentBlock__children"]//button
    #Gets the count of the buttons present
    ${length}=                  Get Length                      ${elements} 
    ${length}=                  Evaluate                        ${length} + 1
    ${count_button}=    Set Variable    0
    #Running for respective Get Now and as well as remaining buttons
    FOR     ${index}  IN RANGE     1     ${length}
        ${Button_click}=                                         Get Text                              xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]        
        IF   "${Button_click}" == "Get Started, Its Free" or "${Button_click}" == "Get JioFiber" or "${Button_click}" == "Know More" or "${Button_click}" == "Get JioPagesTV"
            Wait For And Click Element     xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]
            IF  "${App_name}" == "JioPages"
                Switch Window                               NEW 
                ${name}=   Get Text    xpath=//title
                Take Page Screenshot            ${name}    
                Close Window
                Switch Window                               MAIN 
            ELSE IF    "${Button_click}" == "Get JioFiber"
                URL Validation    https://www.jio.com/selfcare/interest/fiber/?nav=g  
                Go Back
            ELSE IF     "${Button_click}" == "Know More"
                IF    ${count_button} == 0
                    URL Validation      https://jiogames.com/devices/jiophone 
                ELSE    
                    URL Validation      https://developer.jiogames.com/
                END
                ${count_button}=    Evaluate    ${count_button} + 1
                Go Back
            ELSE IF     "${Button_click}" == "Get Started, Its Free"
            URL Validation      https://jiomeetpro.jio.com/signup
            Go Back
            ELSE IF     "${Button_click}" == "Get JioPagesTV"
            URL Validation      https://play.google.com/store/apps/details?id=com.jio.web.androidtv&hl=en&gl=US
            Go Back
            ELSE
                ${name}=   Get Text    xpath=//title
                # URL Validation                ${locator}
                Take Page Screenshot                ${name}
                Go Back
            END
        ELSE
            Wait For And Click Element                              xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]                        
            ${elements}=  Get WebElements                           xpath=//div[@class="j-modal-content"]//img
            #Finds how many buttons are there in the Popup
            ${length of elements}=                                  Get Length           ${elements}
            #Following Loop does the following operations for the number of buttons it has. i.e Playstore, Appstore, Go to Website
            # 1. Clicks the button -> Validates URL-> Takes Screenshot -> Goes back -> Clicks again
            IF  ${length of elements} == 2
                Popup Content Verification
                Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore
                Wait For And Click Element                          xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]
                Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/AppStore.png"]    ${POPUP_URL}[1]    ${App_name}_AppStore                         
                Wait For And Click Element                          xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]        
                Click Close Button
            ELSE IF   ${length of elements} == 3
                Popup Content Verification
                Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore
                Wait For And Click Element                          xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]
                Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/AppStore.png"]    ${POPUP_URL}[1]    ${App_name}_AppStore   
                Wait For And Click Element                          xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]
                Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/GoToWebsite.png"]    ${POPUP_URL}[2]    ${App_name}_Website   
                Wait For And Click Element                          xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]   
                Click Close Button
            ELSE IF   "${App_name}" == "JioPages"
                Verify Apps Page Loaded                                  ${App_name}
                URL Validation                                      ${POPUP_URL}[1]
                Take Page Screenshot                                ${App_name}_PlayStore
                Go Back   
            ELSE IF    "${App_name}" == "JioMeet"
                Take Page Screenshot                                ${App_name}_JioMeetexe
            ELSE IF    "${App_name}" == "JioHome"
                Take Page Screenshot                                ${App_name}_JioHomeexe  
            ELSE
                Popup Content Verification
                Redirection On Clicking                             xpath=//img[@src="https://jep-asset.akamaized.net/jio/svg/android-ios-logo/G-Play.png"]    ${POPUP_URL}[0]    ${App_name}_PlayStore
                Wait For And Click Element                          xpath=(//div[@class="j-contentBlock__children"]//button)[${index}]  
                Click Close Button
            END
        END
    END



Jio App Information Page Redirection
    #Clicks the Know More Button
    IF   "${App_name}" == "MyJio"
        Redirect And Continue                 xpath=//div[@class="css-1viv00l"]//div[@class="j-button-group"]//button[2]    ${App_URL}    ${App_name}
    ELSE
        Redirect And Continue                 xpath=//div[@aria-label="${App_name}"]//div[@class="j-button-group"]//button[2]    ${App_URL}    ${App_name} 
    END

    
Smart Features Verification
    IF    "${App_name}" == "JioPOS Lite"
        Scroll To                              xpath=//h3[normalize-space()='Become a JioPartner and start earning now']
        Take Element Screenshot                xpath=//section[@aria-label='Become a JioPartner and start earning now']//div[@class='j-grid']    JioPartner
           
        Scroll To                              xpath=//h2[normalize-space()='3 Simple Steps and your business is all set!']
        Take Element Screenshot                xpath=//section[@aria-label='benefits section']//div[@class='j-grid']    Business_Steps
        
        ${count}=     Set Variable  0
        #Checks and verifies the content for Smart Feature Section
        ${features}=  Get WebElements    xpath=//div[@class="j-card h-100 size--xs card-vertical no-top-padding"]
        ${steps}=     Get WebElements    xpath=//div[@class="j-contentBlock j-contentBlock__size-xxs"]//div[contains(@class,"j-contentBlock__body")]
        FOR  ${feature}  IN  @{features}
            Wait For And Verify Element                 ${feature}
            Wait For And Verify Element           xpath=(//div[@class="j-card__image ratio-wide"]/img)[${count} +1]
            Text Verification                           ${feature}       ${Smart_Features}[${count}] 
            ${count}=    Evaluate     ${count} + 1    
        END
        ${count}=     Set Variable     0
        FOR  ${step}  IN  @{steps}
            Wait For And Verify Element     ${step}
            Logo Verification           xpath=(//div[@class="caption-icon j-container l-layout--flex"]//span[@class="j-icon j-icon__bg"])[${count} +1]
            Wait For And Verify Content              ${step}      ${JPL_Steps}[${count}]
            ${count}=  Evaluate  ${count} + 1 
        END
    ELSE IF   "${App_name}" == "JioGames"
        Scroll To                              xpath=//h2[normalize-space()='Limitless features for limitless gaming']
        ${JH}=  Set Variable   0
        ${count}=   Set Variable   0
        WHILE    ${JH} < 8
            ${features}=  Get WebElements      xpath=//div[@id="panel-${JH}"]//div[@class="j-contentBlock j-contentBlock__size-xxs"]
            #Checks and verifies the content for Smart Feature Section
            FOR  ${feature}  IN  @{features}
                Wait For And Verify Element                ${feature}
                Logo Verification                          xpath=//span[@class='j-icon j-icon__bg']
                Text Verification                          ${feature}       ${Smart_Features}[${count}] 
                ${count}=   Evaluate     ${count} + 1    
               
            END
            Take Element Screenshot            xpath=//section[@aria-label="benefits section"]    Limitless_Features_Tab_${JH}
            ${JH}=   Evaluate     ${JH} + 1
            #Increments JH value to go to the next section(2nd iteration) of smart features
            IF  ${JH} == 7  BREAK
            #Clicks the next section of smart features
            Wait For And Click Element         xpath=//section[@aria-label="benefits section"]//button[@aria-controls='panel-${JH}']
        END
    ELSE 
        Scroll To                              xpath=//section[@aria-label="benefits section"]
        Take Element Screenshot                xpath=//section[@aria-label='benefits section']//div[@class='j-grid']        Smart_Features
        ${count}=   Set Variable   0
        ${features}=  Get WebElements          xpath=//div[@class="j-contentBlock j-contentBlock__size-xxs"]
        #Checks and verifies the content for Smart Feature Section
        FOR  ${feature}  IN  @{features}
            Wait For And Verify Element              ${feature}
            Logo Verification                  xpath=(//span[@class="j-icon j-icon__bg"])[${count} + 1]
            Text Verification                          ${feature}       ${Smart_Features}[${count}] 
            ${count}=   Evaluate     ${count} + 1   
        END
    END 

Testimonials Verification 
    Scroll To                                  xpath=//h3[@class="j-heading j-text-heading-m"]
    Take Element Screenshot                    xpath=//h3[@class="j-heading j-text-heading-m"]        ${App_name}_Testimonials
    
    ${features}=  Get WebElements              xpath=//div[@class="j-card h-100 css-1gw70x size--xs card-vertical"]
    IF    "${App_name}" == "JioMart"
        ${features}=  Get WebElements          xpath=//div[@class="j-card h-100 css-13aakr1 size--xs card-vertical j-card__shadow"]
    END
    #Checks and verifies the content for Testimonial Section
    FOR  ${feature}  IN  @{features}
        Wait For And Verify Element                ${feature} 
    END

Apps FAQ Verification
    IF  "${App_name}" == "JioHome" or "${App_name}" == "JioGames"
        Scroll To                               xpath=//section[@aria-label='faqs by category section']
        IF  "${App_name}" == "JioHome"
            Scroll To                              xpath=//section[@aria-label='faqs by category section']
        ELSE
            Scroll To                              xpath=//section[@aria-label='faqs by category section']
        END
        #Gets the no of section of FAQ section present excluding current one
        ${countFAQ}=    Get Element Count                xpath=//div[@class="faqs-by-category"]//button[@class="css-1xxg4v6 j-tab j-tab-size__medium"]
        #This Variable JH is for iterating the section of FAQ section
        ${JH}  Set Variable   0
        WHILE    ${JH} < ${countFAQ + 1}
            ${features}=  Get WebElements      xpath=//div[@class="j-accordion"]//div[@class="j-listBlock__block-text"]
            #Verifies the FAQ Questions present
            FOR  ${feature}  IN  @{features}
                Wait For And Verify Element               ${feature} 
            END
            # Takes screenshot for respective apps
            IF  "${App_name}" == "JioHome"
                Take Element Screenshot        xpath=//section[@aria-label='faqs by category section']        FAQ_Tab_${JH}
            ELSE
                Take Element Screenshot        xpath=//section[@aria-label='faqs by category section']    FAQ_Tab_${JH}
            END
           #increments JH. To go to the next section of FAQ section
            ${JH}=   Evaluate     ${JH} + 1
            
            IF  ${JH} == 5  BREAK
            #Clicks the next section of FAQ section
            Wait For And Click Element     xpath=(//div[@class="faqs-by-category"]//button[@class="css-1xxg4v6 j-tab j-tab-size__medium"])[${JH}]
                 
        END
    ELSE 
        ${count}=   Set Variable   0
        Take Element Screenshot                xpath=//section[@aria-label='faqs section']        FAQ
            
        ${features}=  Get WebElements          xpath=//div[@class="j-accordion"]//div[@class='j-accordion-panel' and @role='tablist']
       #for all other apps, it just verifies the questions  
        FOR  ${feature}  IN  @{features}
            Wait For And Verify Element                ${feature} 
            ${count}=   Evaluate     ${count} + 1
 
        END
    END     

Checking Video Section
    IF     "${App_name}" == "JioPages" 
        #clicks on the video
        Wait For And Click Element             xpath=//div[@class="j-card h-100 size--xs card-vertical j-card__has-fullCardCTA no-top-padding j-card__shadow"]
        #Verifies the video
        Wait For And Verify Element            xpath=//div[@class="j-text j-text-body-m"]//h5[@class='j-heading j-text-heading-xs']
        #plays the video
        Wait For And Click Element             xpath=//div[@class="j-modal-content"]
        #Takes screenshot
        Take Page Screenshot                   Video_Play
        #Closes the video
        Wait For And Click Element             xpath=//button[@class='j-button j-button-size__medium tertiary icon-primary icon-only']
        
    ELSE
        #This is for JioPOS Lite
        #There are 3 videos
        FOR  ${i}  IN RANGE    1  3
            #Clicks on video
            Wait For And Click Element         xpath=(//div[@class="j-card h-100 size--xs card-vertical j-card__has-fullCardCTA no-top-padding j-card__shadow"])[${i}]
            #Verifies the video
            Wait For And Verify Element        xpath=//div[@class="j-text j-text-body-m"]//h5[@class='j-heading j-text-heading-xs']
            #plays the video
            Wait For And Click Element         xpath=//div[@class="j-modal-content"]
            #Takes screenshot
            Take Page Screenshot               Video_Play
            #Closes the video
            Wait For And Click Element         xpath=//button[@class='j-button j-button-size__medium tertiary icon-primary icon-only']
        END
    END


#---------------------------- Support Local_Keywords -------------------------------

video Verification
    Sleep    2s
    #check if video preview window is visible
    Wait Until Element Is Visible            xpath://video[@id='videoCustom']
    Element Attribute Value Should Be        xpath://video[@id='videoCustom']    autoplay    true    
    #click on close button
    Wait For And Click Element               xpath://button[@class="j-button j-button-size__small tertiary icon-primary icon-only video-btn-close-custom"]

verify 'still need to discuss something?' section
    Scroll To                                xpath://section[@class="j-container bg--primary-background"]
    Wait For And Verify Content              xpath://h2[contains(text(),'Still need to discuss something?')]    Still need to discuss something?
    #verify the buttons in the section
    ${buttons}=    Get WebElements           xpath://button[@class="j-button j-button-size__medium secondary icon-primary icon-primary-inline j-button-flex "]
    FOR    ${button}    IN    @{buttons}
        Wait For And Verify Element          ${button}
        ${text}=    Get Text                 ${button}
        Wait For And Verify Content          ${button}               ${text}
    END

Redirect and continue  
   [Arguments]                               ${Button}               ${WebPageURL}    ${Sc_name}
    Scroll To                                ${Button}                 
    Wait For And Click Element               ${Button}              
    Sleep     1s
    URL Validation                           ${WebPageURL}
    Take Page Screenshot                     ${Sc_name}
    Log To Console                           ${Sc_name}     Redirection Successful

Chat-bot verification
    #verify chat bot
    Wait For And Verify Element              xpath://div[@class="sticky_chat_wrap"]
    Wait For And Verify Content              xpath://section[@class="chatbot-header"]                        JioCare
    Take Page Screenshot                     Sc_chatBoxOpens
    #click on close button
    Wait For And Click Element               xpath://a[@class="close_chatbox"]

Tab Verification        
    #Locate Us Heading
    Text Verification                         xpath=//h1[normalize-space()='Locate us']              ${locateus_text}[0]
    #Search Bar
    Wait For And Verify Element               xpath=//input[@placeholder='Enter your location here']
    #Stores Tab
    Text Verification                         xpath=//span[normalize-space()='Stores']             ${tabtext}[0]
    #Service Centers Tab
    Text Verification                         xpath=//span[normalize-space()='Service Centers']     ${tabtext}[1]
    #Hotspots Tab
    Text Verification                         xpath=//span[normalize-space()='Hotspots']           ${tabtext}[2]


