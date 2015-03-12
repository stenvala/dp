function [X W] = getGaussNodesStandardTriangle(degree)
  % Get Gauss nodes and weights for a standard triangle in barycentric
  % coordinates
  %
  % output:
  %   - X includes the barycentric coordinates
  %   - W includes the weights
  %
  % parameters:
  %   - degree (polynomials of this degree will be integrated exactly)
  %
  % Created: Antti Stenvall (antti@stenvall.fi)
  %
  
  degree = max(degree,1);
  
  switch degree
    case 1
      W = 1;
      
      X = ones(1,3)/3;
      
    case 2
      W = [1;1;1]/3;
      
      X = [4, 1, 1; ...
        1, 4, 1; ...
        1, 1, 4]/6;
      
    case 3
      W = [-9/16 ; 25/48 ; 25/48 ; 25/48];
      
      X = [1/3, 1/3, 1/3; ...
        3/5, 1/5, 1/5; ...
        1/5, 3/5, 1/5; ...
        1/5, 1/5, 3/5];
      
    case 4
      W = [0.109951743655322; ...
        0.109951743655322; ...
        0.109951743655322; ...
        0.223381589678011; ...
        0.223381589678011; ...
        0.223381589678011];
      
      X = [0.816847572980459, 0.091576213509771, 0.091576213509771; ...
        0.091576213509771, 0.816847572980459, 0.091576213509771; ...
        0.091576213509771, 0.091576213509771, 0.816847572980459; ...
        0.108103018168070, 0.445948490915965, 0.445948490915965; ...
        0.445948490915965, 0.108103018168070, 0.445948490915965; ...
        0.445948490915965, 0.445948490915965, 0.108103018168070];
      
    case 5
      W = [0.225000000000000;
        0.125939180544827; ...
        0.125939180544827; ...
        0.125939180544827; ...
        0.132394152788506; ...
        0.132394152788506; ...
        0.132394152788506];
      
      X = [0.333333333333333, 0.333333333333333, 0.333333333333333; ...
        0.797426985353087, 0.101286507323456, 0.101286507323456; ...
        0.101286507323456, 0.797426985353087, 0.101286507323456; ...
        0.101286507323456, 0.101286507323456, 0.797426985353087; ...
        0.059715871789770, 0.470142064105115, 0.470142064105115; ...
        0.470142064105115, 0.059715871789770, 0.470142064105115; ...
        0.470142064105115, 0.470142064105115, 0.059715871789770];
      
    case 6
      
      W = [0.050844906370207; ...
        0.050844906370207; ...
        0.050844906370207; ...
        0.116786275726379; ...
        0.116786275726379; ...
        0.116786275726379; ...
        0.082851075618374; ...
        0.082851075618374; ...
        0.082851075618374; ...
        0.082851075618374; ...
        0.082851075618374; ...
        0.082851075618374];
      
      X = [0.873821971016996, 0.063089014491502, 0.063089014491502; ...
        0.063089014491502, 0.873821971016996, 0.063089014491502; ...
        0.063089014491502, 0.063089014491502, 0.873821971016996; ...
        0.501426509658179, 0.249286745170910, 0.249286745170910; ...
        0.249286745170910, 0.501426509658179, 0.249286745170910; ...
        0.249286745170910, 0.249286745170910, 0.501426509658179; ...
        0.636502499121399, 0.310352451033785, 0.053145049844816; ...
        0.636502499121399, 0.053145049844816, 0.310352451033785; ...
        0.310352451033785, 0.636502499121399, 0.053145049844816; ...
        0.053145049844816, 0.636502499121399, 0.310352451033785; ...
        0.310352451033785, 0.053145049844816, 0.636502499121399; ...
        0.053145049844816, 0.310352451033785, 0.636502499121399];
      
    case 7
      
      W = [-0.149570044467670; ...
        0.175615257433204; ...
        0.175615257433204; ...
        0.175615257433204; ...
        0.053347235608839; ...
        0.053347235608839; ...
        0.053347235608839; ...
        0.077113760890257; ...
        0.077113760890257; ...
        0.077113760890257; ...
        0.077113760890257; ...
        0.077113760890257; ...
        0.077113760890257];
      
      X = [0.333333333333333, 0.333333333333333, 0.333333333333333; ...
        0.479308067841923, 0.260345966079038, 0.260345966079038; ...
        0.260345966079038, 0.479308067841923, 0.260345966079038; ...
        0.260345966079038, 0.260345966079038, 0.479308067841923; ...
        0.869739794195568, 0.065130102902216, 0.065130102902216; ...
        0.065130102902216, 0.869739794195568, 0.065130102902216; ...
        0.065130102902216, 0.065130102902216, 0.869739794195568; ...
        0.638444188569809, 0.312865496004875, 0.048690315425316; ...
        0.638444188569809, 0.048690315425316, 0.312865496004875; ...
        0.312865496004875, 0.638444188569809, 0.048690315425316; ...
        0.048690315425316, 0.638444188569809, 0.312865496004875; ...
        0.312865496004875, 0.048690315425316, 0.638444188569809;...
        0.048690315425316, 0.312865496004875, 0.638444188569809];
      
    otherwise
      error('Unknown degree for Gaussian quadrature.')
  end