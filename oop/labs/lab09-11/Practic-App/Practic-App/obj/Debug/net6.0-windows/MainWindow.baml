   M S B A M L   `   `   `  ����F  BPractic-App, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null)clr-namespace:Practic_AppPractic_App  5   	   G(clr-namespace:Practic_App.MVVM.ViewModelPractic_App.MVVM.ViewModel  5   	       Practic_App.MainWindow   5   	   W SPresentationCore, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=6.0.2.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=6.0.2.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   +localclr-namespace:Practic_App     5   	   >	viewModel(clr-namespace:Practic_App.MVVM.ViewModel     5   	     � Title$  
MainWindow��5	   	   $	��500��6   $	��800��6)      WindowStyle#���   5
   	    � DataContext 5      .   (Practic_App.MVVM.ViewModel.MainViewModal  5   
    � 	Resources 5       �� MergedDictionaries �� Source�� 5   
    5      �� 5      $ ./styles/MainStyles.xaml?�6%   �� 5      $ ./styles/InputTheme.xaml?�6%   �� 5      $$ ./styles/RadioButtonTheme.xaml?�6%   �� 5      $ ./styles/ButtonTheme.xaml?�6%   %    5      .��5      ��   ContainerStyle#��[ 6   ._�5   
   �  � RowDefinitions 5      �� 5      $��30 �6    6.   �� 5      $��80 �6    6.   �� 5      6"    � ColumnDefinitions 5       �� 5!      $	��150 �6#   61   �� 5"      6%   .+�5%      �� $��2��6     WindowNavbar#��[ 6)   ._�5&      �  5'      �� 5(      6*    5*      �� 5+      6-   �� 5,      $	��120 �6+   69   .+�5/      ��  	 Title#��[ 6   $
��Shop��6;   $��0��6J   $��0��6W   �� 50      $��Right=�6!    �� Orientation$ 
Horizontal=�6=   $��0��6V   $��1��6c   .+�51      ��   	NavButton#��[ 6P   ��6!   �� *MinimizeApplicationCommand+��52      �� 53   "   $��20��6(   $!��./assets/icons/minimize.png��63   55      �� 56      #��[ 6M   ��6!   �� *CloseApplicationCommand+��57      �� 58   "   $��20��6(   $��./assets/icons/close.png��63   5:      5;      5<      5=      �� 5?      $��10q�6   $c��]D:\уник\ооп ч2\лабораторные\Practic-App\Practic-App\assets\icons\logo.ico��6    $��1��6s   $��0��6�   � 5@      $��1��6   $��1��6     5A      �� 5B      �� 5C      $	��130 �6'    5E      �� 5F      .+�5H      �� $��15q�6   $��40��6&   �� 5I      $��1��6   $��Sign In��6)   $��0 0 15 0q�6;   ��6M   �� *LoginWindowCommand+��5J      �� 5K       �� 
TargetType" ��6    	 �� BasedOn#	 [B��64   .�5L      �� 
 �� Property
 � y� �� Value$ Visible=�6;    �� Triggers 5M      �� 5N   "    �� Binding 6.   �� *
IsLoggedIn+ �� Value True6M   .a�5O   &   �� 
 � y�$ 	Collapsed=�6C   5P   #   5R      5T      �� 5U      $��1��6   $��Log Out��6)   $��0 0 15 0q�6;   ��6M   �� *LogOutCommand+��5V      �� 5W      " ��6    #	 [B��64   .�5X      �� 
 � y�$ 	Collapsed=�6;    5Y      �� 5Z   "    6.   �� *
IsLoggedIn+ True6M   .a�5[   &   �� 
 � y�$ Visible=�6C   5\   #   5^      5`      5a      �� 5c      $��2��6   $��0��6&   ��5d      �� 5e      " ��6   .�5f      �� 
 � y�$ 	Collapsed=�67    5g      �� 5h       6*   �� *	IsAdmin+ True6F   .a�5i   "   �� 
 � y�$ Visible=�6?   5j      5l      .+�5n      	� $��
Tovar List��6C    d� 	IsChecked$
 TrueY�6X   ��6   �� *TovarListCommand+6X   	� 5o      $��	Add Tovar��6B   ��6   �� *AddTovarCommand+6B   	� 5p      $��Delete Tovar��6G   ��6   �� *DeleteProductCommand+6G   5q      �� 5s      $��2��6   $��0��6&   ��5t      �� 5u      " ��6   .�5v      �� 
 � y�$ 	Collapsed=�67    5w      �� 5x       6*   �� *	IsAdmin+	 False6F   .a�5y   "   �� 
 � y�$ Visible=�6?   5z      5|      .+�5~      	� $��
Tovar List��6C   $
 TrueY�6X   ��6   �� *TovarListCommand+6X   	� 5      $��Basket��6   ��6/   �� *BasketCommand+��5�      �� 5�      " 	�6    #	 [B	�69   .�5�      �� 
 � y�$ 	Collapsed=�6;    5�      �� 5�   "    6.   �� *
IsLoggedIn+ True6M   .a�5�   &   �� 
 � y�$ Visible=�6C   5�   #   5�      5�      5�      �� 5�      $��2��6   $��1��6*   ��6:   �� *CurrentView+5�      5�      5�      