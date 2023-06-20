*** Settings ***
Resource                           ../../../../Local_Keywords.robot
Resource                           ../../JioFi_PO/JioFI_ProductPage.robot
Resource                           ../../Smart_Devices_PO/SmartDevicesPagePO/AllProducts.robot

*** Keywords ***
Checking UI & Functionality of SmartDevices Product Page
    Checking Product Smart Devices Page UI                #Testcase: 92671
    Checking Device Specs & View Details                  #Testcase: 92682,92683
    Confirm redirection of the breadcrumbs hyperlinks     #Testcase: 92688
    Checking "View All Specifications"                    #Testcase: 92672

Checking UI and functionality of Pincode and Delivery Section
    Pincode Verification                                 #Testcase: 92675                                 
    Confirm the functionality of Click here text         #Testcase: 92681

Checking Accordion Functionality
    Open All Accordions