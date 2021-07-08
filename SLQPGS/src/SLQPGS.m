% SLQPGS class
classdef SLQPGS

  % Class properties (private access)
  properties (SetAccess = private, GetAccess = private)
    
    i           % Input object
    o           % Output object
    c           % Counter object
    p           % Parameter object
    z           % Iterate object
    l           % Log object
    d           % Direction object
    a           % Acceptance object
    output_on   % boolean
    logging_on  % boolean
    
  end
  
  % Class methods
  methods
  
    % Constructor
    function S = SLQPGS(prob)

      % Construct classes
      S.i = Input(prob);
      S.output_on = ischar(S.i.output) || S.i.output;
      if S.output_on
        S.o = Output(S.i.output);
      end
      S.c = Counter;
      S.p = Parameter;
      S.z = Iterate(S.i,S.c,S.p);
      S.logging_on = ~isempty(S.i.log_fields);
      if S.logging_on
        S.l = Log(S.i,S.z);
      end
      S.d = Direction(S.i);
      S.a = Acceptance;

    end
    
    % Gets primal solution and the log 
    function [x,log] = getSolution(S)
      x = S.z.getx;
      log = [];
      if S.logging_on 
        log = S.l.getLog();
      end
    end
    
    % Optimization algorithm
    function optimize(S)

      % Print header and line break
      if S.output_on 
        S.o.printHeader(S.i);
        S.o.printBreak(S.c);
      end
      
      % Iteration loop
      while ~S.z.checkTermination(S.i,S.c,S.d)    
        if S.output_on, S.o.printIterate(S.c,S.z); end
        S.d.evalStep(S.i,S.c,S.p,S.z);
        if S.output_on, S.o.printDirection(S.z,S.d); end
        S.a.lineSearch(S.i,S.c,S.p,S.z,S.d);
        if S.output_on, S.o.printAcceptance(S.a); end
        S.z.updateIterate(S.i,S.c,S.p,S.d,S.a,1);
        if S.logging_on, S.l.logData(); end
        S.c.incrementIterationCount;
        if S.output_on, S.o.printBreak(S.c); end
      end
      
      % Print footer and terminate
      if S.output_on
        S.o.printFooter(S.i,S.c,S.z,S.d);
      end
      
    end
        
  end
  
end
