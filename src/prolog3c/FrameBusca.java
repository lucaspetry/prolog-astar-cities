package prolog3c;

import java.awt.Font;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.util.Hashtable;

import javax.swing.DefaultComboBoxModel;
import javax.swing.JButton;
import javax.swing.JComboBox;
import javax.swing.JLabel;
import javax.swing.JOptionPane;

import jpl.Atom;
import jpl.Query;
import jpl.Term;

public class FrameBusca extends javax.swing.JFrame {

	private static final long serialVersionUID = -4692852763065040016L;
    private JButton btnExecutar;
    private JComboBox<String> cidadeChegada;
    private JComboBox<String> cidadePartida;
    private JLabel labelChegada;
    private JLabel labelPartida;
    private JLabel labelTitulo;
    private String[] cidades;
    
    public FrameBusca() {
    	this.cidades = new String[] { "Araranguá", "Blumenau", "Bom Retiro", "Campo Erê",
    			"Campos Novos", "Canoinhas", "Capinzal", "Chapecó", "Dionísio Cerqueira",
    			"Herval d’Oeste", "Iraí", "Itajaí", "Itapiranga", "Florianópolis", "Joinville",
    			"Lages", "Laguna", "Mafra", "Maravilha", "Monte Castelo", "Navegantes", "Palhoça",
    			"Ponte Alta", "Porto União", "São Lourenço", "São Miguel do Oeste", "Xanxerê" };
    	
        this.initComponents();

    	this.setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
    	this.setLocationRelativeTo(null);
        this.setTitle("Busca A*");
        this.setResizable(false);
        this.setVisible(true);
    }

    private void initComponents() {
        
    	this.btnExecutar = new JButton();
    	this.cidadePartida = new JComboBox<String>(this.cidades);
    	this.cidadeChegada = new JComboBox<String>(this.cidades);
    	this.cidadeChegada.removeItemAt(0);
    	this.labelChegada = new JLabel();
    	this.labelPartida = new JLabel();
    	this.labelTitulo = new JLabel();

    	this.btnExecutar.setFont(new Font("Arial", 0, 16));
    	this.btnExecutar.setText("Executar Busca");
    	this.btnExecutar.addActionListener(new ActionListener() {
			public void actionPerformed(ActionEvent arg0) {
				FrameBusca.this.executarBusca();
			}
		});

    	this.cidadePartida.setFont(new Font("Arial", 0, 16));
    	this.cidadePartida.addItemListener(new ItemListener() {
			@SuppressWarnings("unchecked")
			public void itemStateChanged(ItemEvent arg0) {
				JComboBox<String> c = (JComboBox<String>) arg0.getSource();
				String selecionado = (String) c.getSelectedItem();
				FrameBusca.this.cidadeChegada.removeAllItems();
				FrameBusca.this.cidadeChegada.setModel(
						new DefaultComboBoxModel<String>(FrameBusca.this.cidades));
				FrameBusca.this.cidadeChegada.removeItem(selecionado);
			}
		});
    	this.cidadeChegada.setFont(new Font("Arial", 0, 16));

    	this.labelChegada.setText("Cidade de Chegada:");
    	this.labelChegada.setFont(new Font("Arial", 0, 14));
    	this.labelPartida.setText("Cidade de Partida:");
    	this.labelChegada.setFont(new Font("Arial", 0, 14));

    	this.labelTitulo.setFont(new Font("Arial", 1, 20));
    	this.labelTitulo.setText("Busca A*");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(108, 108, 108)
                .addComponent(btnExecutar)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(53, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addComponent(labelChegada)
                    .addComponent(labelPartida)
                    .addComponent(cidadePartida, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addComponent(cidadeChegada, javax.swing.GroupLayout.PREFERRED_SIZE, 250, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(82, 82, 82)
                        .addComponent(labelTitulo)))
                .addGap(47, 47, 47))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(labelTitulo)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 71, Short.MAX_VALUE)
                .addComponent(labelPartida)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(cidadePartida, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(32, 32, 32)
                .addComponent(labelChegada)
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addComponent(cidadeChegada, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(56, 56, 56)
                .addComponent(btnExecutar)
                .addGap(62, 62, 62))
        );

        pack();
    }

    private void executarBusca() {
    	String resultado = "";
    	String partida = (String) this.cidadePartida.getSelectedItem();
    	String chegada = (String) this.cidadeChegada.getSelectedItem();
    	
    	Query q1 = new Query("consult", new Term[] {new Atom(System.getProperty("user.dir") + "/astarCidades.pl")});
    	
    	try {
    		q1.hasSolution();
    	} catch(Exception e) {
        	JOptionPane.showMessageDialog(null, "Arquivo astarCidades.pl não encontrado! Você deve colocar o arquivo " +
        										"no mesmo diretório do aplicativo!\nErro: " + 
        										e.getMessage(),"Erro", JOptionPane.ERROR_MESSAGE); 
    		return;
    	}
    	
    	Query q2 = new Query("acharCaminho('" + partida + "', '" + chegada + "', Caminho, Distancia)");
    	
    	@SuppressWarnings("rawtypes")
		Hashtable[] solution = q2.allSolutions();	

    	if (solution != null) {	
    		for (int i = 0; i < solution.length; i++) {
    			String caminho = solution[i].get("Caminho").toString();
    			resultado += "Caminho:\n" + caminho.substring(1, caminho.length() - 1) + "\n\n";
    			resultado += "Distância Total: " + solution[i].get("Distancia") + "km\n";
    		}
        	JOptionPane.showMessageDialog(null, resultado, "Resultado da Busca", JOptionPane.INFORMATION_MESSAGE);
    	} else {
        	JOptionPane.showMessageDialog(null, "Nenhuma solução foi encontrada!", "Erro", JOptionPane.ERROR_MESSAGE);    		
    	}
    }

}
