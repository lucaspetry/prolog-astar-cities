package prolog3c;

import javax.swing.UIManager;
import javax.swing.UnsupportedLookAndFeelException;

public class Principal {

	public static void main(String[] args) {
		// Definir o tema nativo do sistema operacional
		String osName = System.getProperty("os.name").toLowerCase();
		try {
			if(osName.indexOf( "win" ) >= 0)
				UIManager.setLookAndFeel( "com.sun.java.swing.plaf.windows.WindowsLookAndFeel" );
			else if(osName.indexOf( "nux" ) >= 0)
				UIManager.setLookAndFeel( "com.sun.java.swing.plaf.gtk.GTKLookAndFeel" );
		} catch (ClassNotFoundException | InstantiationException
				| IllegalAccessException | UnsupportedLookAndFeelException e) {
			e.printStackTrace();
		}

		new FrameBusca();
	}

}
