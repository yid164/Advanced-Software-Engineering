
/*
 * SplashScreen.java - Splash screen
 * Copyright (C) 1998, 2004 Slava Pestov
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 */

package org.gjt.sp.jedit.gui;

import javax.swing.*;
import java.awt.*;
import java.util.Vector;

import org.gjt.sp.jedit.jEdit;
import org.gjt.sp.util.Log;

/**
 * The splash screen displayed on startup.
 * @version $Id: SplashScreen.java 8122 2006-11-24 11:29:49Z kpouer $
 */
public class SplashScreen extends JComponent
{
    public SplashScreen()
    {
        setCursor(Cursor.getPredefinedCursor(Cursor.WAIT_CURSOR));
        setBackground(Color.white);
        
        Font font = new Font("Dialog",Font.PLAIN,10);
        setFont(font);
        fm = getFontMetrics(font);
        
        image = getToolkit().getImage(
                                      getClass().getResource("/org/gjt/sp/jedit/icons/splash.png"));
        MediaTracker tracker = new MediaTracker(this);
        tracker.addImage(image,0);
        
        /*first change start*/
        NameInSplash = new Vector(50);
        String firstRow = "Hao Li, hal356@mail.usask.ca";
        String secondRow = "Ruida Xie, rux793@mail.usask.ca";
        String thirdRow = "YinSheng Dong, yid164@mail.usask.ca";
        NameInSplash.addElement(firstRow);
        NameInSplash.addElement(secondRow);
        NameInSplash.addElement(thirdRow);
        width = Math.max(width, fm.stringWidth(thirdRow)+20);
        position = -210;
        Athread = new NewThread();
        /*first change end*/
        
        try
        {
            tracker.waitForAll();
        }
        catch(Exception e)
        {
            Log.log(Log.ERROR,this,e);
        }
        
        win = new JWindow();
        GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment();
        GraphicsDevice[] gs = ge.getScreenDevices();
        int height = gs[0].getDisplayMode().getHeight();
        int width = gs[0].getDisplayMode().getWidth();
        Dimension screen = new Dimension(width, height);
        Dimension size = new Dimension(image.getWidth(this) + 2,
                                       image.getHeight(this) + 2 + PROGRESS_HEIGHT);
        win.setSize(size);
        
        win.getContentPane().add(this, BorderLayout.CENTER);
        
        win.setLocation((screen.width - size.width) / 2,
                        (screen.height - size.height) / 2);
        win.validate();
        win.setVisible(true);
    }
    
    public void dispose()
    {
        win.dispose();
    }
    
    public synchronized void advance()
    {
        logAdvanceTime(null);
        progress++;
        repaint();
        
        // wait for it to be painted to ensure progress is updated
        // continuously
        try
        {
            wait();
        }
        catch(InterruptedException ie)
        {
            Log.log(Log.ERROR,this,ie);
        }
    }
    
    public synchronized void advance(String label)
    {
        logAdvanceTime(label);
        progress++;
        this.label = label;
        repaint();
        
        // wait for it to be painted to ensure progress is updated
        // continuously
        try
        {
            wait();
        }
        catch(InterruptedException ie)
        {
            Log.log(Log.ERROR,this,ie);
        }
    }
    
    private void logAdvanceTime(String label)
    {
        long currentTime = System.currentTimeMillis();
        if (lastLabel != null)
        {
            Log.log(Log.DEBUG, SplashScreen.class, lastLabel +':'+(currentTime - lastAdvanceTime) + "ms");
        }
        if (label != null)
        {
            lastLabel = label;
            lastAdvanceTime = currentTime;
            
        }
        
    }
    
    public synchronized void paintComponent(Graphics g)
    {
        Dimension size = getSize();
        
        g.setColor(Color.black);
        g.drawRect(0,0,size.width - 1,size.height - 1);
        
        g.drawImage(image,1,1,this);
        
        // XXX: This should not be hardcoded
        g.setColor(Color.white);
        g.fillRect(1,image.getHeight(this) + 1,
                   ((win.getWidth() - 2) * progress) / PROGRESS_COUNT, PROGRESS_HEIGHT);
        
        g.setColor(Color.black);
        
        if (label != null)
        {
            g.drawString(label,
                         (getWidth() - fm.stringWidth(label)) / 2,
                         image.getHeight(this) + (PROGRESS_HEIGHT
                                                  + fm.getAscent() + fm.getDescent()) / 2);
        }
        
        
        String version = jEdit.getVersion();
        g.drawString(version,
                     getWidth() - fm.stringWidth(version) - 2,
                     image.getHeight(this) - fm.getDescent());
        
        int catchHeight = fm.getHeight();
        int TopRow = position / catchHeight;
        
        int firstRowOffset = 100;
        
        int allRows = (getHeight() - 150)/catchHeight;
        
        int answer = firstRowOffset;
        
        
        for(int i=0;i<=allRows;i++){
            if(i+TopRow >= 0 && i + TopRow < NameInSplash.size()){
                String line = (String)NameInSplash.get(i + TopRow);
                g.drawString(line, 20, answer);
            }
            
            answer += fm.getHeight();
        }
        
        notify();
    }
    
    
    public void addNotify(){
        super.addNotify();
        Athread.start();
    }
    
    public void deleteNotify(){
        super.removeNotify();
        Athread.kill();
    }
    
    class NewThread extends Thread{
        private boolean runable = true;
        private long last;
        
        NewThread(){
            super("get thread");
            setPriority(Thread.MIN_PRIORITY);
        }
        
        public void kill(){
            runable = false;
        }
        
        public void run(){
            FontMetrics fm = getFontMetrics(getFont());
            int maxSize = (NameInSplash.size() * fm.getHeight());
            
            
            while (runable){
                position += 10;
                
                if(position > maxSize){
                    position = -250;
                }
                
                if(last != 0){
                    long delay = System.currentTimeMillis() - last;
                    
                    
                    
                    try{
                        Thread.sleep(75 - delay);
                    }
                    catch(Exception e){
                        
                    }
                    
                    
                    
                }
                
                last = System.currentTimeMillis();
                
                repaint(getWidth() / 2 - width, 120, width * 2, getHeight() - 150);
                
            }
        }
        
        
    }
    
    
    
    // private members
    private final FontMetrics fm;
    private final JWindow win;
    private final Image image;
    private int progress;
    private static final int PROGRESS_HEIGHT = 20;
    private static final int PROGRESS_COUNT = 28;
    private String label;
    private String lastLabel;
    private long lastAdvanceTime = System.currentTimeMillis();
    
    /* new varibles*/
    Vector NameInSplash;
    int width;
    int position;
    NewThread Athread;
    
    
    
    
    
}

