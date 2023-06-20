*** Settings ***
Resource                               ../../../Common.robot
Resource                               ../../../Excel_Activity.robot
Resource                               ../../../Local_Keywords.robot
Variables                              ../../../../Tests/Support/Discover_Variables.yaml
Variables                              ../../../Common_Variables.yaml

*** Keywords ***
Shortcuts To Most Used Services Redirection And UI Verification
    #Scrolling down to Shortcuts to most used services section
    Wait For And Verify Element              css:a[title='Need help?']
    #92462
    Scroll To                                xpath=//div[contains(text(),'Check all the support links')]
    Check UI And Content Of 'Shortcuts To Most Used Services' Section

Check UI And Content Of 'Shortcuts To Most Used Services' Section
    #92463
    #Verifying if Shortcuts to most used services section is visible
    Wait For And Verify Element              xpath=//div[normalize-space()='Shortcuts to most used services']
    #Verifying content of Shortcuts to most used services section 
    Wait For And Verify Content              xpath=//div[normalize-space()='Shortcuts to most used services']                   ${Shortcuts_to_Most_Used_Services}    #(STMUS-Shortcuts to Most used services)
    # Verifying Get all the quick links here text
    Wait For And Verify Content              xpath=//div[normalize-space()='Get all the quick links here.']                     ${Shortcuts_to_Most_Used_Services_SubHeading}    #(STMUS-Shortcuts to Most used services)
    #Verifying if all elements are present under Shortcuts to most used services
    FOR    ${index}    IN RANGE    1   7    
        Wait For And Verify Element          xpath://div[@id='nonloggedin']//div[contains(@class,'j-text j-text-body-xs j-relative')][normalize-space()='${Shortcuts_to_Most_Used_Services_Data[${index-1}]}']
        Wait For And Verify Content          xpath://div[@id='nonloggedin']//div[contains(@class,'j-text j-text-body-xs j-relative')][normalize-space()='${Shortcuts_to_Most_Used_Services_Data[${index-1}]}']                             ${Shortcuts_to_Most_Used_Services_Data}[${index-1}] 
    END  
    #Check all the Support links Button Verification 
    Wait For And Verify Element              xpath=(//div[contains(text(),'Check all the support links')])[1]

'Track Order' Page redirection and content verification
    #92464
    Redirect and continue                    xpath=//div[@id='nonloggedin']//a[1]    ${Shortcuts_to_Most_Used_Services_URL[0]}   Sc_TrackOrder        #(STMUS-Shortcuts to Most used services)
    Check UI Elements And Content Of 'Track Order' Page
    
Check UI Elements And Content Of 'Track Order' Page 
    #92465
    #Track order Title,Subtext verification
    Wait For And Verify Content              xpath=//h1[normalize-space()='Track order']                                      ${TrackOrder1}            #(TOdata-Track Order)
    Wait For And Verify Content              xpath=//label[normalize-space()='Enter order tracking details']                  ${TrackOrder2}            #(TOdata-Track Order)       
    #Order Tracking Details Verification
    Text Verification                        xpath=//section[contains(@class,"desktopContent")]//div[@class="j-text j-text-body-s"]    ${TrackOrder}      
    #Verifying and Clicking Hyperlink 'How to Find Tracking order details'
    Wait For And Verify Element              xpath=(//div[contains(text(),'How to find order tracking details?')])
    Wait For And Click Element               xpath=(//div[contains(text(),'How to find order tracking details?')])
    #Verifying if the popup opens on clicking Hyperlink
    Wait For And Verify Element              xpath=(//div[contains(@class,'j-modal j-modal-visible j-modal-closable j-modal-size-m j-modal-kind-dialog')])
    #Clicking Hyperlink
    Wait For And Click Element               xpath=//button[@class='j-button j-button-size__medium tertiary icon-primary icon-only']//i[@class='j-button-icon']
    #Scrolling down to Proceed button And Verify
    Scroll To                                xpath=(//section[@class='submitDetails_button__1q-kM j-container l-layout--full'])[1]
    Wait For And Verify Element              xpath=(//section[@class='submitDetails_button__1q-kM j-container l-layout--full'])[1]
 
Manage Autopay Redirects User To 'Manage Autopay' Page 
    #92468
    #Redirection to Manage AutoPay from Shortcuts to most used services 
    Redirect and continue                    xpath=//div[@id='nonloggedin']//a[3]   ${Shortcuts_to_Most_Used_Services_URL[1]}    Sc_AutoPay        #(STMUS-Shortcuts to Most used services)

UI Elements And Content Of 'Manage Autopay' Page
    #92469
    #Content Verification(Title,Subtext)
    Wait For And Verify Element              xpath=(//span[normalize-space()='Easy just got easier!'])[1]
    #Title ,Subtext Verification 
    FOR    ${index}    IN RANGE   1    3    
        Wait For And Verify Content          xpath://span[contains(text(),'${AutoPay}[${index}]')]                                   ${AutoPay}[${index}]
    END
    # for Mobile (Prepaid/Postpaid) & JioFiber (Prepaid) Text Verification
    Wait For And Verify Content              xpath=//p[contains(text(),'for Mobile (Prepaid/Postpaid) & JioFiber (Prepaid)')]    ${AutoPay2}
    #Verifying if dropdown is present
    Wait For And Verify Element              xpath=//div[@class='react-select1 css-2b097c-container']
    Wait For And Click Element               xpath=//div[@class='react-select1 css-2b097c-container']
    #Verifying if Dropdown options are presents
    Wait Until Page Contains                                                                                                    ${AutoPay}[6]
    Wait Until Page Contains                                                                                                    ${AutoPay}[7]
    #Scrolling down to What is JioAutoPay 
    Scroll To                                xpath=//div[@class='css-17w4881']
    #What is JioAutoPay Content Verification
    Wait For And Verify Content              xpath://div[contains(text(),'What is JioAutoPay')]                                   ${AutoPay}[3]
    FOR    ${index}    IN RANGE    1    4      
        Wait For And Verify Content          xpath://li[contains(text(),'${AutoPay3}[${index}]')]                                     ${AutoPay3}[${index}]
    END    
    Scroll To                                xpath://div[@class='css-1opm9fx']
    #Benefits of JioAutoPay
    Wait For And Verify Content              xpath=//h1[normalize-space()='Benefits of JioAutoPay']                              ${AutoPay}[4]
    FOR    ${index}    IN RANGE    4    11   
        Wait For And Verify Content          xpath=//div[contains(text(),'${AutoPay3}[${index}]')]                                   ${AutoPay3}[${index}]  

    END 
    Scroll To                                xpath=//h1[contains(text(),'How to activate JioAutoPay')]
    #How to Activate JioAutopay content verification
    #UPI section content verification
    Wait For And Verify Content              xpath=(//div[@class='css-uvgvg'])[1]                                               ${AutoPay}[8]
    #Bank Account content verification
    Wait For And Verify Content              xpath=(//div[@class='css-uvgvg'])[2]                                               ${AutoPay}[9]
    #Verifying Activate JioAutoPay Button
    Wait For And Verify Element              xpath=//button[@class='css-1is6bdg e9roze40']
    #Scroll to FAQ Section
    Scroll To                                xpath=//button[@id='5']
    #FAQ Section Verification Title 
    Wait For And Verify Content              xpath=//h1[normalize-space()='Frequently Asked Questions']                         ${AutoPay}[10]     
    #FAQ Section Verification  
    FOR    ${index}    IN RANGE   1    6    
        #Verifying FAQS Content 
        Wait For And Verify Content          xpath://span[contains(text(),'${AutoPayFAQ[${index}]}')]                             ${AutoPayFAQ}[${index}]    
    END

'Lost Sim' Page redirection and content verification
    #Redirection to Lost Sim from Shortcuts to most used services
    #Click on lost SIM 
    #92470
    Scroll To                                xpath=//div[normalize-space()='Get all the quick links here.']
    Redirect and continue                    xpath=//*[@id="nonloggedin"]/a[4]    ${Shortcuts_to_Most_Used_Services_URL[2]}    Sc_LostSim             #(STMUS-Shortcuts to Most used services)
    UI element and content of Lost SIM verification

Track Request Redirection
    #Redirection to Track Request from Shortcuts to most used services
    #92466
    Redirection On Clicking                  xpath=//*[@id="nonloggedin"]/a[2]    ${Shortcuts_to_Most_Used_Services_URL[3]}    Sc_TrackRequest       #(STMUS-Shortcuts to Most used services)
    #Sleep    1s
    Reload Page

Track Request UI Verification
    #92467
    Scroll To                                xpath://div[@class='SignInMainContainer_leftHeader__3nOFu j-text j-text-heading-s']
    Wait For And Verify Content              xpath://div[contains(text(),'Manage your Digital Life with the MyJio app')]    ${TrackRequest_data1}[0]        #(TrackRequest_data1-Track Request data)
    FOR    ${index}    IN RANGE    1   5  
        Wait For And Verify Content          xpath://div[contains(text(),'${TrackRequest_data2[${index-1}]}')]   ${TrackRequest_data2[${index-1}]}    
    END  
    #Welcome page title and subtitle verification
    Text Verification                        xpath=//h2[contains(text(),"Welcome to Jio")]    ${TrackRequest_data1}[1]
    Wait For And Verify Content              xpath=//h1[normalize-space()='Log in to unlock a world of digital experiences.']    ${TrackRequest_data3}[0]     #(TrackRequest_data1-Track Request data)   
    #Verifying if Two Tabs Mobile and JioFiber is present 
    Wait For And Verify Content              xpath=//div[@class='j-text'][normalize-space()='Mobile']    ${TrackRequest_data1}[2]
    Wait For And Verify Content              xpath=//div[@class='j-text'][normalize-space()='JioFiber']    ${TrackRequest_data1}[3]
    #Checking presence of Mobile Icon
    Wait For And Verify Element              xpath=//span[@class='SubmitNumbers_iconColor__lr6SG j-icon']
    #Verifying Mobile Search Field Placeholder
    Wait For And Verify Content              xpath=//label[normalize-space()='Mobile Number']                            ${TrackRequest_data3}[1]            #(TrackRequest_data1-Track Request data)
    #Checking presence of JioFiber Icon 
    Wait For And Verify Element              xpath=//span[@class='SubmitNumbers_defaultIconColor__1jtwh j-icon']
    #Switching Tab,Verifying Fiber Search Field Placeholder Placeholder
    Wait For And Click Element               xpath=//div[@class='j-text'][normalize-space()='JioFiber']
    Wait For And Verify Content              xpath=//label[normalize-space()='JioFiber Number']                            ${TrackRequest_data3}[2]          #(TrackRequest_data1-Track Request data)
    #Checking  Presence of Generate OTP button
    Wait For And Verify Element              xpath=//button[@aria-label='button Generate OTP']
    #Verifying if QR is present and its Content
    Wait For And Verify Element                       xpath=//img[@alt='myjioQRimage']    
    #Verifying Whole Container of Download MyJio now
    Wait For And Verify Element              xpath://section[@class='SignInMainContainer_qrContainer__1TVUu j-container l-radius--xl']
    FOR    ${index}    IN RANGE    3    5       
            Wait For And Verify Content      xpath://div[contains(text(),'${TrackRequest_data3}[${index}]')]    ${TrackRequest_data3}[${index}]                                 #(TrackRequest_data1-Track Request data)
    END
    #Checking presence of Login Options and Login popup
    Wait For And Verify Element              xpath=//span[normalize-space()='Other login options: JioFi, Lost SIM, etc.']
    Wait For And Click Element               xpath=//span[normalize-space()='Other login options: JioFi, Lost SIM, etc.']
    Wait For And Verify Element              xpath=//div[@class='j-modal-container']
    Wait For And Verify Content              xpath=//div[normalize-space()='Login options']    ${TrackRequest_data1}[4]                                      #(TrackRequest_data1-Track Request data)
  
UI element and content of Lost SIM verification 
    #92471
    #Verify back button
    Wait For And Verify Element              xpath=//img[@alt='Back']
    #Verify heading
    Wait For And Verify Content              xpath=(//h1[normalize-space()='Lost SIM login'])    ${LostSIM}
    Wait For And Verify Element              xpath=//input[@data-testid="jInput-id"]
    #Verifying Placeholder
    Wait For And Verify Content              xpath=//h2[normalize-space()='Enter your Jio number']    ${LostSIMText}[0]
    #Verifying (Suspend / Resume / Access PUK code / Track your phone)
    Wait For And Verify Content              xpath://span[contains(text(),'(Suspend / Resume / Access PUK code / Track your phone)')]    ${LostSIMText}[1]
    #verify proceed button
    Wait For And Verify Element              xpath=//button[contains(text(), "Proceed")]
    #Image Verification
    Wait For And Verify Element              xpath=//div[@class="css-1vbaeps"]

Port to Jio redirection,UI and content verification
    Scroll To                                xpath=//div[normalize-space()='Get all the quick links here.']
    #92472
    Redirect and continue                    xpath=//div[@id='nonloggedin']//a[5]    ${PortToJioURL}    Sc_PortToJio
    Verify content of 'port to jio'

Verify content of 'port to jio'
    #92473
    #PO1-Port to Jio
    #Title verification
    Text Verification                        xpath=(//div[contains(text(),'Port to Jio')])[1]                                     ${PO1,2_Title}[0]
    #sub-title and body text verification
    Text Verification                        xpath=//h3[contains(text(),'Switch to Jio for unmatched benefits')]                  ${PO1,2_SubTitle}[0]
    Text Verification                        xpath=//div[contains(text(),'Superfast internet, unlimited data, FREE voice cal')]   ${PO1,2_Body}[0]
    #image and button verification
    Wait For And Verify Element                       xpath=//img[@src="/mnp-desk.jpg"]
    PortToJio button verification            xpath=//button[contains(text(),'Raise Porting Request')]
    
    #PO2-Change your network
    #scroll to the section
    Scroll To                                xpath=//section[@id='mnp-steps-section']
    #title, subtitle and body text verification
    Text Verification                        xpath=//h3[contains(text(),'Change your network without changing your number')]      ${PO1,2_title}[1]
    Text Verification                        xpath=//div[contains(text(),'Seamlessly move your current number from any mobil')]   ${PO1,2_SubTitle}[1]
    Text Verification                        xpath=//div[contains(text(),'Switch to Jio in 3 simple steps')]                      ${PO1,2_Body}[1]
    #3 steps verification
    FOR    ${PO_text}    IN RANGE    1  4
        #title verification
        Text Verification                    xpath=(//div[@class="j-card__header d-flex j-heading j-text-heading-xxs"])[${PO_text}]                                    ${PO1,2_Title}[${PO_text+1}]
        #subtitle verification
        Text Verification                    xpath=(//section[@id="mnp-steps-section"]//h3[@class="j-contentBlock__title j-heading j-text-heading-m"])[${PO_text}]     ${PO1,2_SubTitle}[${PO_text+1}]
        #body text verification
        Text Verification                    xpath=(//section[@id="mnp-steps-section"]//div[@class="j-contentBlock__description j-text j-text-body-m"])[${PO_text}]    ${PO1,2_Body}[${PO_text+1}]
    END
    #button verification
    PortToJio button verification            xpath=(//button[contains(text(),'Port to Jio')])[1]
    
    #PO3-incredible plans
    #scroll to the section
    Scroll To                                xpath=//button[contains(text(),'View all plans')]
    #verification of the 3 plans cards
    FOR    ${index}    IN RANGE    1  4
        #plan title verification
        Text Verification                    xpath:(//div[@class="j-badge j-badge-size__small"])[${index}]                                                                                         ${Plan_Title}[${index-1}]
        #plan price verification
        Text Verification                    xpath:(//div[@class="j-card bg--primary-20 size--s card-vertical w-100"]//h3[@class="j-contentBlock__title j-heading j-text-heading-m"])[${index}]    ${Plan_Price}[${index-1}]
        #text below price
        Text Verification                    xpath=//div[contains(text(),'Unlimited Voice and SMS')]                                                                                           Unlimited Voice and SMS
        #icons verification
        Wait For And Verify Element          xpath=//div[@class="app-icon-list d-flex align-items-center"]
        #plan validity verification
        Text Verification                    xpath:(//div[@class="j-card bg--primary-20 size--s card-vertical w-100"]//div[contains(text(),"days")])[${index}]                                     ${Plan_Validity}[${index-1}]
        #plan benefits verification
        Text Verification                    xpath:(//div[@class="j-card bg--primary-20 size--s card-vertical w-100"]//div[contains(text(),"GB/")])[${index}]                                      ${Plan_Benefits}[${index-1}]
        #check details button verification
        check details button verification    xpath:(//button[@class="j-button j-button-size__medium secondary"])[${index}]            ${index-1}
    END
    #button verifications
    PortToJio button verification            xpath=//button[@id='sim']
    Redirection On Clicking                  xpath=//button[contains(text(),'View all plans')]                                    ${Url_ViewAllPlans}                                          Sc_ViewAllPlans   
    
    #PO4-here's why millions prefer jio
    #scroll to the section
    Scroll To                                xpath=//div[@class="l-layout--max-width overflow-scroll-max-width"]
    #title verification
    Text Verification                        xpath://h2[contains(text(),"Here's why millions prefer Jio")]                        Here's why millions prefer Jio
    FOR    ${index}    IN RANGE    1  7
        #icon verification
        Wait For And Verify Element          xpath:(//span[@class="j-icon j-icon__bg"])[${index}]
        #title verification
        Text Verification                    xpath:(//div[@class="j-contentBlock__title j-heading j-text-body-s-bold"])[${index}]     ${PO4,5_Title}[${index-1}]
        #body text verification
        Text Verification                    xpath:(//div[contains(@class,'j-text-body-s j-color-primary-grey-80')])[${index}]    ${PO4,5_SubTitle}[${index-1}]    
    END 
    
    #PO5-port your number
    #scroll to the section
    Scroll To                                xpath=//section[@id="whyTrigger"]
    #title and body text verification
    Text Verification                        xpath=//h3[contains(text(),'Port your number to Jio without stepping out')]          ${PO4,5_Title}[6]
    Text Verification                        xpath=//div[contains(text(),'Book a Jio SIM online, raise a porting request thr')]   ${PO4,5_SubTitle}[6]
    #image and button verification
    Wait For And Verify Element                       xpath=//img[@src="/porttojio-mnp-desk.png"]
    PortToJio button verification            xpath=//section[@id="whyTrigger"]//button
    
    #PO6-FAQs
    #scroll to the section
    Scroll To                                xpath=(//section[@class="j-container l-layout--max-width"])[2]
    #title verification
    Text Verification                        xpath=//h2[contains(text(),'FAQ')]    FAQ
    #FAQs text verification
    FOR    ${index}    IN RANGE    1  6
        Text Verification                    xpath:(//div[@class="mg--top"]//*[@class="j-accordion-panel"])[${index}]                 ${FAQ}[${index-1}]
    END
    
    #PO7-port your current number to jio
    #scroll to the section
    Scroll To                                xpath=//section[@class="j-container"]//div[@class="l-layout--max-width"]
    #title and body text verification
    Text Verification                        xpath=//h2[contains(text(),'Port your current number to Jio from the comfort o')]    ${PortYourno_title}
    Text Verification                        xpath=//p[contains(text(),'Order a new Jio SIM online, raise a request for mo')]     ${PortYourno_subtitle}[0]
    Text Verification                        xpath=//p[contains(text(),'Followed by the KYC process at home, your new Jio ')]     ${PortYourno_subtitle}[1]

verify redirection and content of 'claim refund'
    #scroll to 'shortcuts to services' section
    Scroll To                                xpath=//div[contains(text(),'Check all the support links')]  
    #Clicking on check all the support links
    Wait For And Click Element               xpath=//div[@style="flex-basis: unset;"][contains(text(),"Check all the support links")]
    #Scroll to the section
    Scroll To                                xpath=//h2[@class="j-heading j-text-heading-s"][contains(text(),"Payment-related Links")]
    #Clicking on claim refund 
    #check redirection of 'claim refund'
    #92474
    Redirect and continue                    xpath=(//a[@class="txt-align--center icon-circle-transition"])[12]   https://www.jio.com/selfcare/erefund/    Sc_ClaimRefund
    check content of 'claim refund'

check content of 'claim refund'
    #92475
    #verify icon
    Wait For And Verify Element              xpath=//span[@class="j-icon j-icon__bg"]
    #page title and subtitle
    Text Verification                        xpath=//h1[contains(text(),'Claim your Refund')]                                     ${ClaimRefund_title}
    Text Verification                        xpath=//h2[contains(text(),'Terminated your Jio connection or cancelled an ord')]    ${ClaimRefund_subtitle}
    Text Verification                        xpath=//div[contains(text(),'Select the refund type')]                               Select the refund type
    #verify title, subtitle and button of checkbox
    FOR    ${index}    IN RANGE    1  3
        Text Verification                    xpath:(//span[@class="label"]//div[@class="j-text j-text-body-s-bold"])[${index}]                ${Refund_title}[${index-1}]
        Text Verification                    xpath:(//div[@class="j-listBlock__children"]//*[@class="j-text j-text-body-xxs"])[${index}]      ${Refund_subtitle}[${index-1}]
        Wait For And Verify Element          xpath:(//span[@class="slider round"])[${index}]
    END
    #image and button verification
    Wait For And Verify Element              xpath://div[normalize-space()='Continue']
    Wait For And Verify Element                       xpath://img[@src="https://jep-asset.akamaized.net/jiocom/static/images/SimJio.png"]

Verify redirection and content of 'check all support links'
    #scroll to 'shortcuts to services' section
    Scroll To                                xpath=//div[contains(text(),'Check all the support links')]  
    #check redirection of 'check all support links'
    #92476
    Redirect and continue                    xpath=//div[contains(text(),'Check all the support links')]    https://www.jio.com/help/quick-links#/    Sc_QuickLinks
    check content of 'check all support links'

check content of 'check all support links'
    #92477
    #verify page title and subtitle
    Text Verification                        xpath=//h1[contains(text(),'Find all the quick links in one place')]                 ${CheckLinks_title}
    #Text Verification                        xpath=//p[contains(text(),'Here we’ve listed the shortcuts to all the importa')]     ${CheckLinks_subtitle}
    #verify all link titles
    ${index}    Set Variable    0
    FOR    ${i}    IN RANGE    1  6   
        Text Verification                    xpath:(//h2[@class="j-heading j-text-heading-s"])[${i}]                              ${Link_types}[${i-1}]
        ${links}=    Get WebElements         xpath:(//div[@class="j-card size--s j-Space__horizontal j-Space bg--primary-background "])[${i}]//a[@class="txt-align--center icon-circle-transition"]
	    ${count}=    Get Length    ${links}
	    FOR    ${options}    IN RANGE    ${count}  
            Text Verification                xpath:((//div[@class="j-card size--s j-Space__horizontal j-Space bg--primary-background "])[${i}]//*[@class="j-text j-text-body-xs j-relative"])[${options+1}]            ${Link_title}[${index}]
            Wait For And Verify Element      xpath:((//div[@class="j-card size--s j-Space__horizontal j-Space bg--primary-background "])[${i}]//*[@class="icon-size-64 j-icon j-icon__bg j-relative"])[${options+1}]
            ${index}=    Evaluate    ${index}+1
	    END
	
    END    
    #verify 'still need to discuss something' section
    Verify 'still need to discuss something?' section

PortToJio button verification
    [Arguments]                              ${path}
    #click on PortToJio
    Wait For And Click Element               ${path}
    #icon
    Wait For And Verify Element              xpath=(//div[@id="modal-getsim-container"]//span[@class="j-icon j-icon__bg"])[1]
    #title and subtitle
    Text Verification                        xpath=//h5[contains(text(),'Get a Jio SIM')]                                         Get a Jio SIM
    Text Verification                        xpath=//div[@id='modal-getsim-container']//div[contains(text(),'Just validate your number, share your address, and')]         ${PortToJio_subtitle}
    #verify and input name and number fields
    Wait For And Verify Element              xpath=//input[@id='user-name']
    Wait For And Input Text                  xpath=//input[@id='user-name']                                                       ${Name}
    Wait For And Verify Element              xpath=//input[@id='user-number']
    Wait For And Input Text                  xpath=//input[@id='user-number']                                                     ${COCP_OR_Postpaid_Number} 
    #verify generateOTP button
    Wait For And Verify Element              xpath=//button[@id='generateOTP-btn']
    #click on cross button
    Wait For And Click Element               xpath=//button[@data-popup-close="modal-getsim"]

check details button verification
    [Arguments]                              ${path}        ${j}
    #click on check details
    Wait For And Click Element               ${path}
    #verify cross button
    Wait For And Verify Element              xpath=//button[@class="j-button j-button-size__medium tertiary icon-primary icon-only"]
    #title verification
    Text Verification                        xpath=//div[@class="modal_sticky_top"]//span[@class="j-text j-text-body-xxs-bold"]   ${Plan_Title}[${j}]
    #price verification
    Text Verification                        xpath=//div[@class="modal_sticky_top"]//h3                                           ${Plan_Price}[${j}]
    #validity verification
    Text Verification                        xpath=//table//td[contains(text(),'days')]                                           ${Plan_Validity}[${j}]
    #total data verification
    Text Verification                        xpath=//table//td[contains(text(),'GB')]                                             ${Plan_TotalData}[${j}]
    Scroll To                                xpath=//div[@class='j-contentBlock__description j-text j-text-body-xxs']
    #checking list of OTT apps
    ${LOGOs}=  Get WebElements               xpath=//div[@class="txt-align--center"]
    FOR  ${LOGO}  IN  @{LOGOs}
        Wait For And Verify Element          ${LOGO}
    END
    #button verification
    PortToJio button redirection             xpath=//div[@id="plan-detail-modal"]//button[contains(text(),'Port to Jio')]

PortToJio button redirection
    [Arguments]                              ${path}
    Redirection On Clicking                  ${path}        ${Url_PortToJio}    Sc_PortToJioRedirection
    Sleep    200ms