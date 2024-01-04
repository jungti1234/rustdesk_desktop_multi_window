import Cocoa
import FlutterMacOS
import desktop_multi_window
import desktop_lifecycle
import window_manipulator

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    let windowFrame = self.frame
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)
    
    FlutterMultiWindowPlugin.setOnWindowCreatedCallback { controller in
      // Register the plugin which you want access from other isolate.
      DesktopLifecyclePlugin.register(with: controller.registrar(forPlugin: "DesktopLifecyclePlugin"))
      DesktopLifecyclePlugin.register(with: controller.registrar(forPlugin: "windowManipulator"))
    }

    super.awakeFromNib()
  }
}
