%Separation de source avec le premier algorithme
%avec calcul du mu optimal et penalisation
%et trac� des courbes de mu en fonction de lambda et inversement

clear all;close all;clc

%Construction des deux signaux sous forme vectorielle
%Calcul du nombre de ligne et de colonne que l'on se servira pour reconstruire les signaux m�lang�s et s�par�s
[image_vecteur_s1,nbligne_s1,nbcolonne_s1]=decompose('im.png');
[image_dep1,ind1]=imread('im.png');
imshow(image_dep1,ind1)
[image_vecteur_s2,nbligne_s2,nbcolonne_s2]=decompose('picture.png');
[image_dep2,ind2]=imread('picture.png');
figure
imshow(image_dep2,ind2)
%Cr�ation de la matrice de melange
A=[0.6 0.4;0.4 0.6];

%Calcul des deux sorties m�lang�es(x1,x2)
s1=image_vecteur_s1;
s2=image_vecteur_s2;
 
%changement de type des donn�es car on ne peut pas se servir dans entier non sign�
s1=double(s1);
s2=double(s2);
source1=s1;
source2=s2;
source1=source1/std(source1);
source2=source2/std(source2);

x1=A(1,1)*s1+A(1,2)*s2;
x2=A(2,2)*s2+A(2,1)*s1;

%normalisation des deux sorties m�lang�s
x1=x1/std(x1);
x2=x2/std(x2);
 
%reconstruction(moyenn�-centr�) des melanges
xx1=(x1*std(x1));
xx2=(x2*std(x2));
X1=max(abs(xx1));
X2=max(abs(xx2));
xx1=xx1/X1*255;
xx2=xx2/X2*255;

%reconstruction de nos images melang�es
image_matrice_s1=reconstruct(xx1,nbligne_s1,nbcolonne_s1);
figure
imshow(image_matrice_s1,ind1)
title('image melangee 1');
image_matrice_s2=reconstruct(xx2,nbligne_s2,nbcolonne_s2);
figure
imshow(image_matrice_s2,ind2)
title('image melangee 2');

%cr�ation de la matrice de s�paration
nb_iter=500;
B=eye(2);
mu=0.05;   
lam=2.;
    y1=x1;
    y2=x2;
    for i=1:nb_iter
    i
    m_y1=mean(y1);
    m_y12=mean(y1.^2);
    m_y13=mean(y1.^3);
    m_y14=mean(y1.^4);
    m_y15=mean(y1.^5);
    m_y16=mean(y1.^6);
    m_y2=mean(y2);
    m_y22=mean(y2.^2);
    m_y23=mean(y2.^3);
    m_y24=mean(y2.^4);
    m_y25=mean(y2.^5);
    m_y26=mean(y2.^6);

    %Calcul des diff�rents parametres
    K1=[1 m_y1 m_y12 m_y13];
    K2=[1 m_y2 m_y22 m_y23];
    M1=[1 m_y1 m_y12 m_y13;m_y1 m_y12 m_y13 m_y14;m_y12 m_y13 m_y14 m_y15;m_y13 m_y14 m_y15 m_y16];
    M2=[1 m_y2 m_y22 m_y23;m_y2 m_y22 m_y23 m_y24;m_y22 m_y23 m_y24 m_y25;m_y23 m_y24 m_y25 m_y26];
    P1=[0;1;2*m_y1;3*(m_y12)];
    P2=[0;1;2*m_y2;3*(m_y22)];
    w1=-inv(M1)*P1;
    w2=-inv(M2)*P2;
          
    %calcul du Psi
    Psi_y1=w1(1)+w1(2)*y1+w1(3)*y1.^2+w1(4)*y1.^3;
    Psi_y2=w2(1)+w2(2)*y2+w2(3)*y2.^2+w2(4)*y2.^3;
    Psi_y=[Psi_y1 Psi_y2];
    
    %calcul de mu optimal avec la hessienne
    %der1= derivee de Psi_y1 resp Psi_y2
    der1 = w1(2)+2*w1(3)*y1+3*w1(4)*y1.^2;
    der2 = w2(2)+2*w2(3)*y2+3*w2(4)*y2.^2;
    %Calcul du B
    M_Psi11=mean(Psi_y1.*x1);
    M_Psi12=mean(Psi_y1.*x2);
    M_Psi21=mean(Psi_y2.*x1);
    M_Psi22=mean(Psi_y2.*x2);
    
    %calcul du mu optimal
     y1=y1-mean(y1);y2=y2-mean(y2);
    %Calcul permettant de normaliser B : penalisation
    temp1=4*(mean(y1.^2)-1)*y1;
    temp2=4*(mean(y2.^2)-1)*y2;
    m_y1x1=mean(temp1.*x1);
    m_y1x2=mean(temp1.*x2);
    m_y2x1=mean(temp2.*x1);
    m_y2x2=mean(temp2.*x2);
    pen=[m_y1x1 m_y1x2;m_y2x1 m_y2x2];

    B=B-mu*(-B'*[M_Psi11 M_Psi12;M_Psi21 M_Psi22]-eye(2))-mu*lam*pen;
    BB1(i)=B(1,1);
    BB2(i)=B(1,2);
    BB3(i)=B(2,1);
    BB4(i)=B(2,2);

    %calcul de la separation
    y1=B(1,1)*x1+B(1,2)*x2;
    y2=B(2,2)*x2+B(2,1)*x1;
    
    %calcul fictif pour recuperer la moyenne et la variance
    yy1=B(1,1)*xx1+B(1,2)*xx2;
    yy2=B(2,2)*xx2+B(2,1)*xx1;  
%     m_yy1=mean(yy1);
%     m_yy2=mean(yy2);
    e_yy1=std(yy1);
    e_yy2=std(yy2);
   
    y1est = y1;             %pour calcul des ecarts types
    y2est = y2;

end

%reconstruction grace a la variance et 
%moyenne du signal a partir des melanges
y1=y1*e_yy1;
y2=y2*e_yy2;

V1=y1/max(y1)*255;
V2=y2/max(y2)*255;
imagematrices1=reconstruct(V1,nbligne_s1,nbcolonne_s1);
YY1=uint8(imagematrices1);
figure
imshow(YY1,ind1)
title('image separee 1');
imagematrices2=reconstruct(V2,nbligne_s2,nbcolonne_s2);
YY2=uint8(imagematrices2);
figure
imshow(YY2,ind2)
title('image separee 2');    


% 
% %calcul des rapports signal/bruit(diaphonie)
BA=B*A;
bruit1=BA(1,2)*source2;
bruit2=BA(2,1)*source1;
RSBB1=10*log(mean(y1est.^2)/mean(bruit1.^2))
RSBB2=10*log(mean(y2est.^2)/mean(bruit2.^2))

%     end 
% end





figure
subplot(4,1,1)
plot(BB1)
subplot(4,1,2)
plot(BB2)
subplot(4,1,3)
plot(BB3)
subplot(4,1,4)
plot(BB4)

