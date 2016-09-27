Pod::Spec.new do |s|
    s.name         = "FUTableViewIndexBar"
    s.version      = "1.0.1"
    s.summary      = "custom FUTableViewIndexBar"
    s.homepage     = "https://github.com/FuJunZhi/FUTableViewIndexBar"
    s.license      = "MIT"
    s.authors      = {"fujunzhi" => "185476975@qq.com"}
    s.platform     = :ios, "7.0"
    s.source       = {:git => "https://github.com/FuJunZhi/FUTableViewIndexBar.git", :tag => s.version}
    s.source_files = "FUTableViewIndexBar/*.{h,m}"
    s.requires_arc = true
end