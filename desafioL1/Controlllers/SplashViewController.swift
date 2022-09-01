import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Método que irá chamar a próxima ViewController através do identificador da ligacão(StoryBoard Segue), também foi adicionado 2 segundos para o efeito.
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.performSegue(withIdentifier: "toMovies", sender: nil)
        }
    }
}
