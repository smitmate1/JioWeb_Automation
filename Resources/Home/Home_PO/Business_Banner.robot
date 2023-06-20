***Settings*** 
Library                                 SeleniumLibrary
Resource    ../../Common.robot

***Keywords***
Business Banner Validation
    # Scroll to Make your business grow faster than ever section
    
    Scroll Element Into View        xpath=//a[normalize-space()='View job openings']
    Sleep    1s
    Reload Page
    Scroll Element Into View         xpath=//div[@class='j-card j-fullwidth-banner p-0']//a[@aria-label="Explore JioBusiness"] 
    
    
    # Heading Content Verification
    
    Text Verification                            xpath=//h3[normalize-space()='Grow your business faster than ever']     Grow your business faster than ever
    CSS Verification                             xpath=//h3[normalize-space()='Grow your business faster than ever']        font-weight    900

    # Sub-Heading Content Verification
    Wait For And Verify Element                  xpath=//div[contains(text(),'Future-ready business solutions.')]   
    
    # Background Image Verification
    Wait For And Verify Element                  xpath=//div[contains(@class,'l-breakpoint--desktop')]//img[contains(@alt,'Explore JioBusiness')]   
    
    # Button Verification
    Wait For And Verify Element                  xpath=//button[contains(text(),'Explore JioBusiness')]
    Text Verification                            xpath=//button[contains(text(),'Explore JioBusiness')]     Explore JioBusiness
                                
    Log To Console                               JioBusiness_Section Verified
         
    # Button Redirection
    Redirection On Clicking                      xpath=//button[contains(text(),'Explore JioBusiness')]      https://www.jio.com/business/   JioBusiness_Page