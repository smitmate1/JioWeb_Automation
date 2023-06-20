*** Settings ***
Resource                             ../../../Common.robot
Variables                           ../../../../Tests/Support/ContactCentre_Variables.yaml
Resource                             ../../../Excel_Activity.robot
Resource                            ../../../Local_Keywords.robot

*** Keywords ***

#92656 TestCase
Contact Centre section is visible in Support tab Verification
    #Underline verification under Contact Centre subheading
    CSS Verification                    xpath=//li[@class='cursor-pointer active']    border-bottom    3px solid rgb(232, 232, 252)
    URL Validation                      ${contact_centre_URL}     
    Take Page Screenshot                SC_Contact_Centre

    Verify UI and content of Contact Centre page
    Confirm UI and content of the search bar dropdown 
    Confirm on entering any random string suggested searches are shown
    Switching from one subheading to other Subheading
    Confirm on clicking the Email subheading the form appears
    Confirm user is redirected to confirmation popup on clicking Submit button
    Confirm on clicking the Call subheading particular options are shown there
    Confirm the functionality of all accordion in Call section
    Confirm UI and content of the 'Appellate Authority' popup
    

#92657 TestCase
Verify UI and content of Contact Centre page
    
    #Welcome to Jio Support heading
    Text Verification                 xpath=//h1[normalize-space()='Welcome to Jio Support']         Welcome to Jio Support
    #Font Verification
    CSS Verification                  xpath=//h1[normalize-space()='Welcome to Jio Support']         font-weight    900

    #Support search bar
    Wait For And Verify Element       xpath=//input[@id='supportSearchtxt']       

    #Connect with us heading
    Text Verification                 xpath=//h2[normalize-space()='Connect with us']                Connect with us
    #Font Verification
    CSS Verification                  xpath=//h2[normalize-space()='Connect with us']                font-weight    900

    #Subheading Chat
    Text Verification                 xpath=//span[normalize-space()='Chat']                         Chat    
    #Font Verification
    CSS Verification                  xpath=//span[normalize-space()='Chat']                         font-weight    700

    #Reach out on WhatsApp heading
    Text Verification                 xpath=//div[normalize-space()='Reach out on WhatsApp']         Reach out on WhatsApp     
    #Font Verification               
    CSS Verification                  xpath=//div[normalize-space()='Reach out on WhatsApp']         font-weight    700

    #Chat with JioCare heading
    Text Verification                 xpath=//div[normalize-space()='Chat with JioCare']             Chat with JioCare    
    #Font Verification
    CSS Verification                  xpath=//div[normalize-space()='Chat with JioCare']             font-weight    700

    #Email subheading 
    Text Verification                 xpath=//span[normalize-space()='Email']                        Email
    #Font Verification 
    CSS Verification                  xpath=//span[normalize-space()='Email']                        font-weight    700

    #Call subheading
    Text Verification                 xpath=//span[normalize-space()='Call']                         Call  
    #Font Verification 
    CSS Verification                  xpath=//span[normalize-space()='Call']                         font-weight    700

    #Chat Now button
    Button Verification               xpath=//button[@class="j-button j-button-size__medium primary icon-primary icon-primary-inline"]    

    #Footer Verification
    Section Verification              xpath=//div[@id='sites-footer-container']    Footer   

#92658 TestCase
Confirm UI and content of the search bar dropdown 

    Scroll To                         xpath=(//div[contains(@class,'l-layout--max-width')])[1]
    Sleep    500ms                    #sleep required
    #Entering text
    Wait For And Input Text           xpath=//input[@id='supportSearchtxt']    j
    Sleep    500ms                    #sleep required
    #Clearing text
    Press Keys                        xpath=//input[@id='supportSearchtxt']    BACKSPACE
    Sleep    500ms                    #sleep required
    #Quick links
    Text Verification                 xpath=//div[@id='quicklink-list-id-support']//div[contains(@class,'searchresult-header')][normalize-space()='Quick links']    ${contact_centre_text}[8]
    #Suggested searches
    Text Verification                 xpath=//div[@id='suggested-list-id-support']//div[contains(@class,'searchresult-header')][normalize-space()='Suggested searches']    Suggested searches
    #Verify content of the search bar dropdown   
    FOR    ${content}    IN RANGE      0    8
        Text Verification             xpath=(//div[@class="item-text"])[${content+1}]    ${contact_centre_text}[${content}]  
    END
#92659 TestCase
Confirm on entering any random string suggested searches are shown
    
    #Enter any random strings of length 3
    Wait For And Input Text           xpath=//input[@id='supportSearchtxt']    jio
    Sleep    500ms    
    #User sees the relevant search options in the dropdown 
    Text Verification                 xpath=//ul[@id="suggestions-list-support"]    ${Suggested_Searches_Text}

#92660 TestCase
Switching from one subheading to other Subheading
  
    Scroll To                         xpath=(//span[@class="sp--huge pd--top j-Space__vertical j-Space"])[2]
    #Click on 'Email'                
    Wait For And Click Element        xpath=//span[normalize-space()='Email']
    
    #Click on 'Call'
    Wait For And Click Element        xpath=//li[@onclick="openCity(event, 'appellateCallContent')"]
    Sleep    200ms
    
#92661 TestCase    
Confirm on clicking the Email subheading the form appears

    Scroll To                         xpath=//span[normalize-space()='Email']
    #Click on 'Email'
    Wait For And Click Element        xpath=//span[normalize-space()='Email']
    #Email Subheading text
    Text Verification                 xpath=//div[@class='j-color-primary-grey-100 j-text-body-m-bold']               Any queries? Simply write to us.

    #Textfields Verification
    #Name
    Text Verification                 xpath=//label[normalize-space()='Name']    Name
    #Jio Number/Registered Mobile Number
    Text Verification                 xpath=//label[normalize-space()='Jio Number/Registered Mobile Number']          Jio Number/Registered Mobile Number
    #Email Address
    Text Verification                 xpath=//label[normalize-space()='Email Address']    ${contact_centre_text}[9]    
    #Select Product/Service
    Text Verification                 xpath=//*[@id="type-id-0"]/option[1]    Select Product/Service 
    #Subject
    Text Verification                 xpath=//label[normalize-space()='Subject']    Subject
    #Describe your query or concern in details
    Text Verification                 xpath=//label[normalize-space()='Describe your query or concern in details']    Describe your query or concern in details
    #Upload document
    Text Verification                 xpath=//label[normalize-space()='Upload document']    ${contact_centre_text}[10]    
    #Submit button 
    Text Verification                 xpath=//button[@id='check']    Submit    
    Wait For And Verify Element       xpath=//button[@id='check'] 

    #92662 TestCase
    #Click submit button
    Wait For And Click Element        xpath=//button[@class="j-button j-button-size__medium primary submit-btn"]
    #Error toast appears 'Please enter all fields'
    Text Verification                 xpath=//div[@id='all-field-err']    Please enter all fields   

#92663 TestCase
Confirm user is redirected to confirmation popup on clicking Submit button
    
    Scroll To                         xpath=(//span[@class="sp--huge pd--top j-Space__vertical j-Space"])[2]
    #Click on 'Email'
    Wait For And Click Element        xpath=//span[normalize-space()='Email']    
    #Enter Name
    Wait For And Input Text           xpath=//input[@id='customerName']    ABCD
    #Enter Jio Number/Registered Mobile Number 
    Wait For And Input Text           xpath=//input[@id='number']    ${contact_centre_text}[11]
    #Enter Email Address 
    Wait For And Input Text           xpath=//input[@id='userEmail']    abcd@gmail.com
    #Select Product and Services
    Wait For And Click Element        xpath=//select[@id='type-id-0']
    #Click on 1st option in product and services
    Wait For And Click Element        xpath=//option[@value='Jio Mobile']
    #Enter Subject Field
    Wait For And Input Text           xpath=//input[@id='subj']    subject
    #Describe your query or concern in details
    Wait For And Input Text           xpath=//textarea[@id='eMailBody']    abcdefghijklmnopqrstuvwxyzz
    Scroll To                         xpath=(//span[@class="sp--huge pd--top j-Space__vertical j-Space"])[2]
    #Click on Submit Button
    Wait For And Click Element        xpath=//button[@class="j-button j-button-size__medium primary submit-btn"]  
    #A cross icon at the top
    Wait For And Verify Element       xpath=//button[@data-popup-close="modal-thankyou"]//i[@class="j-button-icon"]    
    #Check icon
    Wait For And Verify Element       xpath=//div[@class='j-contentBlock__caption']//span[@class='j-icon']//*[name()='svg'] 
    #Thank You below the check icon
    Text Verification                 xpath=//h5[normalize-space()='Thank you']    Thank you
    #'Your message has been....' text
    Text Verification                 xpath=//p[contains(text(),'Your message has been submitted successfully. We w')]    Your message has been submitted successfully. We will reply to you shortly.
    #Done button
    Wait For And Verify Element       xpath=//button[normalize-space()='Done']    
    #Click on cross button
    Wait For And Click Element        xpath=//button[@class='j-button j-button-size__medium tertiary icon-primary icon-only']//i[@class='j-button-icon']
    
#92664 TestCase
Confirm on clicking the Call subheading particular options are shown there
    Sleep    2s
    Scroll To                         xpath=//span[normalize-space()='Call']
    #Click on 'Call'
    Wait For And Click Element        xpath=//span[normalize-space()='Call']
    #Options under call section verification
    ${count}=    Set Variable    1  
    FOR    ${option}  IN RANGE    12    17
        Text Verification             xpath=(//div[@class="j-text j-text-body-s-bold"])[${count}]    ${contact_centre_text}[${option}]
        ${count}=    Evaluate    ${count}+1
    END
    #Appellate Authority text
    Text Verification                 xpath=//div[@id="appellateCallContent"]        ${contact_centre_text}[17]

#92665 TestCase
Confirm the functionality of all accordion in Call section
    Check the functionality of all accordions

Check the functionality of all accordions
    FOR    ${accordion}  IN RANGE    5    10
        Scroll To                      xpath=(//span[contains(@aria-label,'button')])[${accordion}]
        #Accordion opens up and text inside is shown
        Wait For And Click Element     xpath=(//span[contains(@aria-label,'button')])[${accordion}]
        #Accordion closes and the text is hidden
        Wait For And Click Element     xpath=(//span[contains(@aria-label,'button')])[${accordion}]
    END
    
    #92666 TestCase
    Scroll To                          xpath=(//span[@class="sp--huge pd--top j-Space__vertical j-Space"])[2]
    #Click on 'Appellate Authority' hyperlink
    Wait For And Click Element         xpath=//div[@id="appellateCallContent"]

#92667 TestCase
Confirm UI and content of the 'Appellate Authority' popup
    #Cross icon verification
    Wait For And Verify Element        xpath=//button[@data-popup-close="modal-get-fiber"] 
    #Appellate Authority heading Verification
    Text Verification                  xpath=//h3[normalize-space()='Appellate Authority']    ${contact_centre_text}[17] 
    #Appellate Authority content Verification
    Text Verification                  xpath=//div[contains(@class,'j-color-primary-grey-80 j-text-body-xs')]    ${Appellate Authority_Text}
    #click on Select your State dropdown
    Wait For And Click Element         xpath=//div[@class='j-modal-body']//div[@class='txt-align--left']//div//div[@class='j-field input-dropdown input-has-suffix']
    #Dropdown states list verification
    FOR  ${state}  IN RANGE    1    29
        Text Verification              xpath=//select[@class="myselect"]//option[${state}]    ${Appellate Authority_states}[${state}]
    END
    