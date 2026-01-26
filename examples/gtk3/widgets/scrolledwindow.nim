# nim c scrolledwindow.nim
import nim2gtk/[gtk, gobject, gio]

const text =
  """
    Voluptatem possimus vel doloremque dolorem pariatur autem cumque
placeat obcaecati tenetur lorem velit minima, autem sit quisquam
nulla molestiae laudantium, rerum. Adipisicing iusto repudiandae
magni doloribus elit, esse molestiae consequuntur adipisci
exercitationem odit expedita quo ipsa alias dolor magni quaerat,
est eaque voluptas voluptatum odit. Eveniet fugiat libero fugit
optio provident dolorem suscipit molestias voluptates labore
recusandae sit, tempora cumque numquam ipsa. Architecto velit
adipisicing quisquam voluptates accusantium expedita;
exercitationem veritatis doloribus odit veniam modi. 

    Doloremque non odit numquam quia; veritatis doloremque velit
impedit esse nulla officiis quisquam temporibus corporis obcaecati
fuga non harum magni pariatur. Error sit aliquam laborum ipsa
molestias cupiditate sunt voluptatem libero voluptates quo; eius,
vel commodi recusandae culpa dolor doloremque possimus libero aut
rerum. Totam modi quis ipsa corporis exercitationem similique
provident impedit commodi ab repudiandae cupiditate cumque quo
voluptatem voluptates, molestiae ut accusantium mollitia. Quod
voluptate, fugit suscipit veritatis error quaerat culpa quod eius
neque laudantium esse velit sit ipsum eos optio quam eius dolor,
obcaecati nihil.

    Adipisicing consectetur doloribus debitis explicabo voluptatem
blanditiis impedit veritatis corporis maiores explicabo odit.
Quas; ad voluptatum quam dolorem hic molestiae provident, ut
nesciunt; tenetur excepturi explicabo neque recusandae rerum ad.
Adipisci ipsum eius similique molestiae sit at vel pariatur alias
similique molestiae voluptas, libero mollitia nihil cumque
explicabo perspiciatis. Sit aut quis nesciunt recusandae minima
quisquam adipisicing nulla accusantium lorem.

    Autem explicabo earum fugit reprehenderit fugiat sint repudiandae
voluptatum lorem adipisci expedita eveniet elit eveniet explicabo
temporibus dolor suscipit consectetur cupiditate quibusdam eveniet
provident aliquid. Impedit quo reprehenderit voluptates ipsum
nulla veniam laudantium officia eveniet sit quaerat veniam labore
officia officiis voluptates fuga aut cumque lorem. Officiis
voluptate sunt quibusdam omnis fuga explicabo vel aliquid at
impedit aliquam quisquam architecto accusantium doloribus rerum.
Ab deleniti eligendi cumque eligendi ut ut reprehenderit
architecto doloremque.

    Eaque at consequuntur sapiente laborum eligendi fugiat magni
repudiandae deleniti sunt doloremque non repudiandae qui
doloremque quod quas at ratione; dolorum. Nihil quas pariatur quam
alias sint ad eos iusto voluptates eligendi laborum nihil
veritatis, possimus earum accusantium cumque. Accusantium totam
aliquid aliquid aut similique possimus; expedita minima numquam
eveniet sed sit earum iure voluptate enim quas. Aut voluptatum
eaque voluptatum saepe perspiciatis, odit placeat neque, harum sed
voluptatum. 

    Voluptas excepturi adipisicing consectetur voluptate hic dolorem
ut; maiores, est molestiae quia quam quas tempora excepturi, nulla
modi qui iusto nulla. Suscipit expedita sed quia minima architecto
qui aliquam; eligendi veniam laborum obcaecati adipisci rerum
amet. Esse expedita odit lorem commodi, eaque voluptatem est at
quod culpa. Fugit explicabo error obcaecati; est culpa sed ab
autem blanditiis commodi rerum ab sed fuga. """

proc appActivate(app: Application) =
  let win = newApplicationWindow(app)
  win.title = "Scrolled Window Example"
  win.defaultSize = (300, 200)

  let scrolled = newScrolledWindow()
  scrolled.setPolicy(gtk.PolicyType.automatic, gtk.PolicyType.automatic)
  let label = newLabel(text)

  label.setLineWrap(true)
  scrolled.add(label)

  win.add(scrolled)
  win.showAll()

proc main() =
  let app = newApplication("org.gtk.example.scrolledwindow")
  app.connect("activate", appActivate)
  discard run(app)

main()
