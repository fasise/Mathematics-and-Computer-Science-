%Separation de source avec le premier algorithme MeR 2004

clear all;close all;clc
%decompose transforme une matrice en un vecteur
%Construction des deux signaux sous forme vectorielle
%Calcul du nombre de ligne et de colonne
% dont on se servira pour reconstruire les signaux mélangés 
%et séparés
[image_vecteur_s1,nbligne_s1,nbcolonne_s1]=decompose('test1_gray.png');
[image_dep1,ind1]=imread('test1_gray.png');
imshow(image_dep1,ind1)
title('image source 1');
[image_vecteur_s2,nbligne_s2,nbcolonne_s2]=decompose('test2_gray.png');
[image_dep2,ind2]=imread('test2_gray.png');
figure
imshow(image_dep2,ind2)
title('image source 2');
%Création de la matrice de melange X = A* S,A est l'opérateur de mélange
% dans la "vraie vie", il est inconnu, ici pour tester l'algorithme
% on le simule
A=[0.6 0.4;0.4 0.6];

%les signaux sources (ici les deux images test1 et test2 save
% avec lesquelles on va tester l'algorithme
%inconnues dans la "vraie vie", elles vont nous donner
% les deux sorties mélangées(x1,x2)
s1=image_vecteur_s1;
s2=image_vecteur_s2;
 
%on travaille en double precision 
s1=double(s1);
s2=double(s2);
% on normalise
s1=s1/std(s1);
s2=s2/std(s2);

x1=A(1,1)*s1+A(1,2)*s2;
x2=A(2,1)*s1+A(2,2)*s2;

 
%reconstruction des matrices pour retrouver les images "melangées" associées"
% vecteur --> matrice
%calcul préliminaire
xx1=(x1*std(x1));
xx2=(x2*std(x2));
X1=max(abs(xx1));
X2=max(abs(xx2));
xx1=xx1/X1*255;
xx2=xx2/X2*255;
%reconstruction de nos images melangées
image_matrice_s1=reconstruct(xx1,nbligne_s1,nbcolonne_s1);
figure
imshow(image_matrice_s1,ind1)
title('image melangee 1');
image_matrice_s2=reconstruct(xx2,nbligne_s2,nbcolonne_s2);
figure
imshow(image_matrice_s2,ind2)
title('image melangee 2');

%normalisation des deux sorties mélangées
x1=x1/std(x1);
x2=x2/std(x2);

%création de la matrice de séparation
nb_iter=2000;
B=eye(2);
mu=0.05;   
lam=1.;
y1=x1;
y2=x2;
    for i=1:nb_iter
    
    [GradIM,Gradpen] = compute_gradient(y1,y2,x1,x2);

    B=B-mu*(-B'*GradIM-eye(2))-mu*B'*lam*Gradpen;
    

    %calcul de la separation
    y1=B(1,1)*x1+B(1,2)*x2;
    y2=B(2,1)*x1+B(2,2)*x2;
    
    %calcul fictif pour recuperer la moyenne et la variance
    yy1=B(1,1)*xx1+B(1,2)*xx2;
    yy2=B(2,1)*xx1+B(2,2)*xx2;  
    m_yy1=mean(yy1);
    m_yy2=mean(yy2);
    e_yy1=std(yy1);
    e_yy2=std(yy2);
   
    y1est = y1;             %pour vérifier les écarts types
    y2est = y2;             %rappel : on cherche les sources 
                            %ayant un écart type =1
    
end
% Calcul des matrice de correlation 
%rappel : lorsque deux signaux sont indépendants ou décorrélés
%Cette matrice est la matrice identité
[Mat_cor] = correl_coef_composante_nb(x1,x2)
[Mat_cor] = correl_coef_composante_nb(x1,x2)
[Mat_cor] = correl_coef_composante_nb(y1est,y2est)
 
%reconstruction des matrices pour obtenir les images séparées
%cette reconstruction est obtenu avec l'aide de la variance et 
% la moyenne des images de mélanges

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

% %calcul des rapports signal/bruit(diaphonie)
BA=B*A;
bruit1=BA(1,2)*source2;
bruit2=BA(2,1)*source1;
RSBB1=10*log(mean(y1est.^2)/mean(bruit1.^2))
RSBB2=10*log(mean(y2est.^2)/mean(bruit2.^2))


