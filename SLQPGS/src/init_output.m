function o = init_output(i)

% function o = init_output(i)
%
% Author       : Frank E. Curtis
% Description  : Initializes output values.  File handle for output is
%                set along with labels for printed quantities.
% Input        : i ~ input values
% Output       : o ~ output values
% Last revised : 28 October 2009

% Set output file handle
if ~isfield(i,'fout'), o.fout = 1;
else

  % Open output file for writing
  o.fout = fopen(i.fout,'w');
  
  % Error check for writable output file
  if (o.fout == -1), error('SLQP-GS: Error opening output file.  Please provide a valid file name (i.fout) as a string.'); end;

end

% Set verbosity level
if isfield(i,'verbosity'), o.verbosity = i.verbosity; else o.verbosity = 0; end;

% Store output header and label strings
if o.verbosity == 0 | o.verbosity == 2
  o.line = '=====+=========================================';
  o.quan = '  k  |      f         v        rho       phi';
else
  o.line = '=====+==========================================+=========================================================+=========';
  o.quan = '  k  |      f         v        rho       phi    |    eps      theta   msg    ||d||       m         mred   |   alpha';
  o.none =                                                   '--------  --------  ---  --------  ---------  --------- | --------';
end