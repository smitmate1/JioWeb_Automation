*** Settings ***
Library                               SeleniumLibrary
Resource                              ../../../Common.robot
Resource                              ../../../Local_Keywords.robot
Variables                             ../../../Common_Variables.yaml
Variables                             ../../../../Tests/Shop/JioFi_Variables.yaml



*** Keywords ***
JioFi Page Content Verification       #Testcase:92706
    
    # Verifying Heading JioFI
    Wait For And Verify Content       xpath=//span[@class="page-title"]    JioFi
    
    # Verifying Filter                
    Wait For And Verify Element       xpath=//div[@class="filter-container"]
    CSS Verification                  xpath=//div[@class="filter-container"]    float     right

    # All Products Tile
    Scroll to All Products
    
    # Verifying  Jiofi M2S Tile
    Section Verification              xpath=//div[contains(@class,"prod-image")]    JioFi M2S
    
    # Verifying  JioFi M2S Image
    Wait For And Verify Element                xpath=//img[@id="492337991"]
    
    # Verifying  JioFi M2S Text
    Text Verification                 xpath=//div[@class="pop-prod-title"]//span    JioFi M2S
    
    # Verifying  JioFi M2S Colour
    Text Verification                 xpath=//div[@class="pop-prod-desc mg-bt-8"]//span    Black
    CSS Verification                  xpath=//div[@class="pop-prod-desc mg-bt-8"]//span    text-decoration    none solid rgba(0, 0, 0, 0.65)
    
    # Verifying  JioFi Price
    Wait For And Verify Content       xpath=//div[@class="pop-prod-desc mg-bt-0"]//span    ₹2,800
   
    # Footer Section Verification
    Section Verification              xpath=//div[@id="sites-footer-container"]   Footer_Section   

    #Checking Redirection of Product Page    Testcase:92707
    Scroll To                      xpath=//div[@class="pop-prod-title"]
    Wait For And Click Element     xpath=//div[@class="pop-prod-title"]
    
# -----------------------------------------------------