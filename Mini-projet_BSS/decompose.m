function [image_vecteur,nbligne,nbcolonne]=decompose(image)
% y'a pas d'aide 
%debrouille toi tout seul


[y,ind]=imread(image);

image_vecteur=y(:,1);


%taille de l'image
[nbligne,nbcolonne]=size(y);

%pour les images en couleur
%permet de ne prendre que la 1ere couche de couleurs.
%nbcolonne=nbcolonne/3;

for t=2:nbcolonne
    image_vecteur=cat(1,image_vecteur,y(:,t));
end

% 
% image_vecteur=double(image_vecteur);
% image_vecteur=image_vecteur-mean(image_vecteur);
% image_vecteur=image_vecteur/std(image_vecteur);
% 
% 
% 



