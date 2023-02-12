function image_matrice=reconstruct(vecteur,nbligne,nbcolonne)
%y a pas d aide!!!

% vecteur=vecteur+mean(vecteur);
% vecteur=vecteur/max(vecteur)*255;



image_matrice(:,1)=vecteur(1:nbligne,1);
for c=2:nbcolonne
    G=0;
    for h=((c-1)*nbligne)+1:c*nbligne
        G=G+1;
        image_matrice(G,c)=vecteur(h,1);
    end
end





