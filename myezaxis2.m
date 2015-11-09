function myezaxis2

theAxis = 'y';

theFcn = 'r2atoms';
theInvFcn = 'atoms2r';


bkgdOrig = gca;
orig = copyobj(bkgdOrig,gcf);
thePosition = get(orig, 'Position');
theLim = get(orig, [theAxis 'Lim']);

origYLim = theLim;
origXLim = get(orig,'XLim');
origTick = get(orig,[theAxis 'Tick']);
origTickLabel = get(orig,[theAxis 'TickLabel']);
set(orig, 'YTick',[],'XTick',[]);

for i = 1:length(theLim)
	t = theLim(i);
	theLim(i) = feval(theInvFcn, t);
end

temp = axes('Position', thePosition, 'XAxisLocation','top','YAxisLocation','right','Visible', 'off');
set(temp, [theAxis 'Lim'], theLim);

theTick = get(temp, [theAxis 'Tick']);
theTickLabels = get(temp, [theAxis 'TickLabel']);

delete(temp)

for i = 1:length(theTick)
	t = theTick(i);
	theTick(i) = feval(theFcn, t);
end

% returnToOrig = axes('Position',thePosition,[theAxis 'Lim'], origYLim, 'XLim',origXLim, [theAxis 'Tick'], origTick, [theAxis 'TickLabel'], origTickLabel,'Color','none');
% set(returnToOrig,'YScale','log');


% secondAxes = axes('Position',thePosition,'YAxisLocation','right', [theAxis 'Lim'], theLim,'YMinorTick','off',[theAxis 'TickLabel'], theTickLabels,'Color','none');
set(orig, 'XTick',[],'XTickLabel',{' '},'XAxisLocation','top','YAxisLocation','right',[theAxis 'Tick'], theTick, 'YMinorTick','off',[theAxis 'TickLabel'], theTickLabels,'Color','none')
xlabel(''); title('');
ylabel('Precipitate Radius');
set(gca,'FontSize',30);
set(orig,'box','off');
set(gcf, 'CurrentAxes',bkgdOrig);
set(bkgdOrig,'box','off');
% rotateXLabels(bkgdOrig, 90);




function radius = atoms2r(nAtoms)

%beta-FeSi2 lattice parameters from Dusausoy et al.

    a = 9.863e-8; %cm
    b = 7.791e-8;  
    c = 7.833e-8;
    Z = 16;

    V_FeSi2_unitcell = a*b*c/Z; %cm3, volume of one primitive cell of beta-FeSi2
radius = ((3/4/pi*nAtoms*V_FeSi2_unitcell).^(1/3))/1e-7; %nm


function nAtoms = r2atoms(radius)

%beta-FeSi2 lattice parameters from Dusausoy et al.

    a = 9.863e-8; %cm
    b = 7.791e-8;  
    c = 7.833e-8;
    Z = 16;

    V_FeSi2_unitcell = a*b*c/Z; %cm3, volume of one primitive cell of beta-FeSi2
nAtoms = 4*pi/3*(radius*1e-7).^3/V_FeSi2_unitcell;