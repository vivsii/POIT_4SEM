   M S B A M L   `   `   `  ����C  ?lab04-05, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null#clr-namespace:lab04_05lab04_05  5   	   #    lab04_05.ProductDetailsWindow   5   	   W SPresentationCore, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35\ XPresentationFramework, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35e aSystem.Windows.Controls.Ribbon, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089R NWindowsBase, Version=7.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35F 9http://schemas.microsoft.com/winfx/2006/xaml/presentation     5   	   R NSystem.Xaml, Version=7.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   (localclr-namespace:lab04_05     5   	     � Title$  Versun��5   	   $	��550��6   $	��450��6%    � Icon$ 	/logo.ico��61    � Cursor$X Rd:\уник\ооп ч2\лабораторные\lab07\lab04-05\lab04-05\arrow3.cur��6B   .��5	      �� .��5
   
   �  � RowDefinitions 5      �� 5   
   $
��Auto �6   �� 5   
   $
��Auto �6   �� 5   
   $��* �6   .+�5      �� $��0��6   $
��Bold"�68   $��24(�6J   $��Center=�6X   $
��0,10q�6u   ��6   �� *	ShortName+6u   �� 5      $��1��6   $	��400��66   $	��300��6B   $
��0,10q�6O   $��Center=�6]   ��6   �� *	ImagePath+6]   �� 5      $��2��6   $��10q�6   .+�5   
   �� -   5         ��Name$ DescriptionTextBlock1��5         DescriptionTextBlock1#���   63   $
��Bold"�6b   �� 5   
   $
��Wrap=�61   $	��0,5q�6E   ��6   �� *Description+6E   �� 5   
   -   5        $ PriceTextBlock1��5        PriceTextBlock1#���  6-   $
��Bold"�6V   $
��0,10q�6h   �� 5   
   $	��0,5q�6C   ��6   �� *Price+ �� StringFormat$ {0:C}��6C   �� 5   
   -   5        $ CategoryTextBlock1��5        CategoryTextBlock1#���  60   $
��Bold"�6\   $
��0,10q�6n   �� 5   
   $	��0,5q�6.   ��6   �� *
Category+6.   �� 5   
   -   5        $ RatingTextBlock1��5        RatingTextBlock1#���  6.   $
��Bold"�6X   $
��0,10q�6j   �� 5   
   $	��0,5q�6D   ��6   �� *Rating+$ {0}/5��6D   �� 5   
   -   5        $ QuantityInStock��5        QuantityInStock#���  6-   $
��Bold"�6V   $
��0,10q�6h   �� 5   
   $	��0,5q�6H   ��6   �� *
Quantity+$ 	{0} шт.��6H   �� 5   
   -   5        $! QuantityPurchasedTextBlock1��5        QuantityPurchasedTextBlock1#���  69   $
��Bold"�6n   $
��0,10q�6�   �� 5   
   $	��0,5q�6Q   ��6   �� *QuantityPurchased+$ 	{0} шт.��6Q   �� 5   
   -   5        $ InStock��5        InStock#���  6%   $
��Bold"�6F   $
��0,10q�6X   �� 5    
   $	��0,5q�6�   ��6   �� *IsOutOfStock+  AvailabilityConverter �� 	Converter# [ ��6d   �� *IsOutOfStock+  AvailabilityColorConverter# [ 6�   5!      5"      5#      5$      