/*************************************************************************
Copyright (c) 1980-2007, Jorge Nocedal.

Contributors:
    * Sergey Bochkanov (ALGLIB project). Translation from FORTRAN to
      pseudocode.

This software is freely available for educational or commercial  purposes.
We expect that all publications describing work using this software  quote
at least one of the references given below:
    * J. Nocedal. Updating  Quasi-Newton  Matrices  with  Limited  Storage
      (1980), Mathematics of Computation 35, pp. 773-782.
    * D.C. Liu and J. Nocedal. On the  Limited  Memory  Method  for  Large
      Scale  Optimization  (1989),  Mathematical  Programming  B,  45,  3,
      pp. 503-528.
*************************************************************************/

using System;

class lbfgs
{
    /*
    This members must be defined by you:
    static void funcgrad(double[] x,
        ref double f,
        ref double[] g)
    */


    /*************************************************************************
            LIMITED MEMORY BFGS METHOD FOR LARGE SCALE OPTIMIZATION
                              JORGE NOCEDAL

    The subroutine minimizes function F(x) of N arguments by  using  a  quasi-
    Newton method (LBFGS scheme) which is optimized to use  a  minimum  amount
    of memory.

    The subroutine generates the approximation of an inverse Hessian matrix by
    using information about the last M steps of the algorithm  (instead of N).
    It lessens a required amount of memory from a value  of  order  N^2  to  a
    value of order 2*N*M.

    This subroutine uses the FuncGrad subroutine which calculates the value of
    the function F and gradient G in point X. The programmer should define the
    FuncGrad subroutine by himself.  It  should  be  noted that the subroutine
    doesn't need to waste time for memory allocation of array G,  because  the
    memory is allocated in calling the subroutine. Setting a dimension of array
    G  each  time  when  calling  a  subroutine  will excessively slow down an
    algorithm.

    The programmer could also redefine the LBFGSNewIteration subroutine  which
    is called on each new step. The current point X, the function value F  and
    the  gradient  G  are  passed  into  this  subroutine. It is reasonable to
    redefine the subroutine for better debugging, for  example,  to  visualize
    the solution process.

    Input parameters:
        N   -   problem dimension. N>0
        M   -   number of corrections in the BFGS scheme of Hessian
                approximation update. Recommended value:  3<=M<=7. The smaller
                value causes worse convergence, the bigger will  not  cause  a
                considerably better convergence, but will cause a fall in  the
                performance. M<=N.
        X   -   initial solution approximation.
                Array whose index ranges from 1 to N.
        EpsG -  positive number which  defines  a  precision  of  search.  The
                subroutine finishes its work if the condition ||G|| < EpsG  is
                satisfied, where ||.|| means Euclidian norm, G - gradient, X -
                current approximation.
        EpsF -  positive number which  defines  a  precision  of  search.  The
                subroutine finishes its work if on iteration  number  k+1  the
                condition |F(k+1)-F(k)| <= EpsF*max{|F(k)|, |F(k+1)|, 1}    is
                satisfied.
        EpsX -  positive number which  defines  a  precision  of  search.  The
                subroutine finishes its work if on iteration number k+1    the
                condition |X(k+1)-X(k)| <= EpsX is fulfilled.
        MaxIts- maximum number of iterations. If MaxIts=0, the number of
                iterations is unlimited.

    Output parameters:
        X   -   solution approximation. Array whose index ranges from 1 to N.
        Info-   a return code:
                        * -1 wrong parameters were specified,
                        * 0 interrupted by user,
                        * 1 relative function decreasing is less or equal to EpsF,
                        * 2 step is less or equal EpsX,
                        * 4 gradient norm is less or equal to EpsG,
                        * 5 number of iterations exceeds MaxIts.

    FuncGrad routine description. User-defined.
    Input parameters:
        X   -   array whose index ranges from 1 to N.
    Output parameters:
        F   -   function value at X.
        G   -   function gradient.
                Array whose index ranges from 1 to N.
    The memory for array G has already been allocated in the calling subroutine,
    and it isn't necessary to allocate it in the FuncGrad subroutine.
    *************************************************************************/
    public static void lbfgsminimize(int n,
        int m,
        ref double[] x,
        double epsg,
        double epsf,
        double epsx,
        int maxits,
        ref int info)
    {
        double[] w = new double[0];
        double f = 0;
        double fold = 0;
        double tf = 0;
        double txnorm = 0;
        double v = 0;
        double[] xold = new double[0];
        double[] tx = new double[0];
        double[] g = new double[0];
        double[] diag = new double[0];
        double[] ta = new double[0];
        bool finish = new bool();
        double gnorm = 0;
        double stp1 = 0;
        double ftol = 0;
        double stp = 0;
        double ys = 0;
        double yy = 0;
        double sq = 0;
        double yr = 0;
        double beta = 0;
        double xnorm = 0;
        int iter = 0;
        int nfun = 0;
        int point = 0;
        int ispt = 0;
        int iypt = 0;
        int maxfev = 0;
        int bound = 0;
        int npt = 0;
        int cp = 0;
        int i = 0;
        int nfev = 0;
        int inmc = 0;
        int iycn = 0;
        int iscn = 0;
        double xtol = 0;
        double gtol = 0;
        double stpmin = 0;
        double stpmax = 0;
        int i_ = 0;

        w = new double[n*(2*m+1)+2*m+1];
        g = new double[n+1];
        xold = new double[n+1];
        tx = new double[n+1];
        diag = new double[n+1];
        ta = new double[n+1];
        funcgrad(x, ref f, ref g);
        fold = f;
        iter = 0;
        info = 0;
        if( n<=0 | m<=0 | m>n | epsg<0 | epsf<0 | epsx<0 | maxits<0 )
        {
            info = -1;
            return;
        }
        nfun = 1;
        point = 0;
        finish = false;
        for(i=1; i<=n; i++)
        {
            diag[i] = 1;
        }
        xtol = 100*AP.Math.MachineEpsilon;
        gtol = 0.9;
        stpmin = Math.Pow(10, -20);
        stpmax = Math.Pow(10, 20);
        ispt = n+2*m;
        iypt = ispt+n*m;
        for(i=1; i<=n; i++)
        {
            w[ispt+i] = -(g[i]*diag[i]);
        }
        gnorm = Math.Sqrt(lbfgsdotproduct(n, ref g, 1, ref g, 1));
        if( gnorm<=epsg )
        {
            info = 4;
            return;
        }
        stp1 = 1/gnorm;
        ftol = 0.0001;
        maxfev = 20;
        while( true )
        {
            for(i_=1; i_<=n;i_++)
            {
                xold[i_] = x[i_];
            }
            iter = iter+1;
            info = 0;
            bound = iter-1;
            if( iter!=1 )
            {
                if( iter>m )
                {
                    bound = m;
                }
                ys = lbfgsdotproduct(n, ref w, iypt+npt+1, ref w, ispt+npt+1);
                yy = lbfgsdotproduct(n, ref w, iypt+npt+1, ref w, iypt+npt+1);
                for(i=1; i<=n; i++)
                {
                    diag[i] = ys/yy;
                }
                cp = point;
                if( point==0 )
                {
                    cp = m;
                }
                w[n+cp] = 1/ys;
                for(i=1; i<=n; i++)
                {
                    w[i] = -g[i];
                }
                cp = point;
                for(i=1; i<=bound; i++)
                {
                    cp = cp-1;
                    if( cp==-1 )
                    {
                        cp = m-1;
                    }
                    sq = lbfgsdotproduct(n, ref w, ispt+cp*n+1, ref w, 1);
                    inmc = n+m+cp+1;
                    iycn = iypt+cp*n;
                    w[inmc] = w[n+cp+1]*sq;
                    lbfgslincomb(n, -w[inmc], ref w, iycn+1, ref w, 1);
                }
                for(i=1; i<=n; i++)
                {
                    w[i] = diag[i]*w[i];
                }
                for(i=1; i<=bound; i++)
                {
                    yr = lbfgsdotproduct(n, ref w, iypt+cp*n+1, ref w, 1);
                    beta = w[n+cp+1]*yr;
                    inmc = n+m+cp+1;
                    beta = w[inmc]-beta;
                    iscn = ispt+cp*n;
                    lbfgslincomb(n, beta, ref w, iscn+1, ref w, 1);
                    cp = cp+1;
                    if( cp==m )
                    {
                        cp = 0;
                    }
                }
                for(i=1; i<=n; i++)
                {
                    w[ispt+point*n+i] = w[i];
                }
            }
            nfev = 0;
            stp = 1;
            if( iter==1 )
            {
                stp = stp1;
            }
            for(i=1; i<=n; i++)
            {
                w[i] = g[i];
            }
            lbfgsmcsrch(n, ref x, ref f, ref g, ref w, ispt+point*n+1, ref stp, ftol, xtol, maxfev, ref info, ref nfev, ref diag, gtol, stpmin, stpmax);
            if( info!=1 )
            {
                if( info==0 )
                {
                    info = -1;
                    return;
                }
            }
            nfun = nfun+nfev;
            npt = point*n;
            for(i=1; i<=n; i++)
            {
                w[ispt+npt+i] = stp*w[ispt+npt+i];
                w[iypt+npt+i] = g[i]-w[i];
            }
            point = point+1;
            if( point==m )
            {
                point = 0;
            }
            if( iter>maxits & maxits>0 )
            {
                info = 5;
                return;
            }
            lbfgsnewiteration(ref x, f, ref g);
            gnorm = Math.Sqrt(lbfgsdotproduct(n, ref g, 1, ref g, 1));
            if( gnorm<=epsg )
            {
                info = 4;
                return;
            }
            tf = Math.Max(Math.Abs(fold), Math.Max(Math.Abs(f), 1.0));
            if( fold-f<=epsf*tf )
            {
                info = 1;
                return;
            }
            for(i_=1; i_<=n;i_++)
            {
                tx[i_] = xold[i_];
            }
            for(i_=1; i_<=n;i_++)
            {
                tx[i_] = tx[i_] - x[i_];
            }
            xnorm = Math.Sqrt(lbfgsdotproduct(n, ref x, 1, ref x, 1));
            txnorm = Math.Max(xnorm, Math.Sqrt(lbfgsdotproduct(n, ref xold, 1, ref xold, 1)));
            txnorm = Math.Max(txnorm, 1.0);
            v = Math.Sqrt(lbfgsdotproduct(n, ref tx, 1, ref tx, 1));
            if( v<=epsx )
            {
                info = 2;
                return;
            }
            fold = f;
            for(i_=1; i_<=n;i_++)
            {
                xold[i_] = x[i_];
            }
        }
    }


    private static void lbfgslincomb(int n,
        double da,
        ref double[] dx,
        int sx,
        ref double[] dy,
        int sy)
    {
        int fx = 0;
        int fy = 0;
        int i_ = 0;
        int i1_ = 0;

        fx = sx+n-1;
        fy = sy+n-1;
        i1_ = (sx) - (sy);
        for(i_=sy; i_<=fy;i_++)
        {
            dy[i_] = dy[i_] + da*dx[i_+i1_];
        }
    }


    private static double lbfgsdotproduct(int n,
        ref double[] dx,
        int sx,
        ref double[] dy,
        int sy)
    {
        double result = 0;
        double v = 0;
        int fx = 0;
        int fy = 0;
        int i_ = 0;
        int i1_ = 0;

        fx = sx+n-1;
        fy = sy+n-1;
        i1_ = (sy)-(sx);
        v = 0.0;
        for(i_=sx; i_<=fx;i_++)
        {
            v += dx[i_]*dy[i_+i1_];
        }
        result = v;
        return result;
    }


    private static void lbfgsmcsrch(int n,
        ref double[] x,
        ref double f,
        ref double[] g,
        ref double[] s,
        int sstart,
        ref double stp,
        double ftol,
        double xtol,
        int maxfev,
        ref int info,
        ref int nfev,
        ref double[] wa,
        double gtol,
        double stpmin,
        double stpmax)
    {
        int infoc = 0;
        int j = 0;
        bool brackt = new bool();
        bool stage1 = new bool();
        double dg = 0;
        double dgm = 0;
        double dginit = 0;
        double dgtest = 0;
        double dgx = 0;
        double dgxm = 0;
        double dgy = 0;
        double dgym = 0;
        double finit = 0;
        double ftest1 = 0;
        double fm = 0;
        double fx = 0;
        double fxm = 0;
        double fy = 0;
        double fym = 0;
        double p5 = 0;
        double p66 = 0;
        double stx = 0;
        double sty = 0;
        double stmin = 0;
        double stmax = 0;
        double width = 0;
        double width1 = 0;
        double xtrapf = 0;
        double zero = 0;
        double mytemp = 0;

        sstart = sstart-1;
        p5 = 0.5;
        p66 = 0.66;
        xtrapf = 4.0;
        zero = 0;
        funcgrad(x, ref f, ref g);
        infoc = 1;
        info = 0;
        if( n<=0 | stp<=0 | ftol<0 | gtol<zero | xtol<zero | stpmin<zero | stpmax<stpmin | maxfev<=0 )
        {
            return;
        }
        dginit = 0;
        for(j=1; j<=n; j++)
        {
            dginit = dginit+g[j]*s[j+sstart];
        }
        if( dginit>=0 )
        {
            return;
        }
        brackt = false;
        stage1 = true;
        nfev = 0;
        finit = f;
        dgtest = ftol*dginit;
        width = stpmax-stpmin;
        width1 = width/p5;
        for(j=1; j<=n; j++)
        {
            wa[j] = x[j];
        }
        stx = 0;
        fx = finit;
        dgx = dginit;
        sty = 0;
        fy = finit;
        dgy = dginit;
        while( true )
        {
            if( brackt )
            {
                if( stx<sty )
                {
                    stmin = stx;
                    stmax = sty;
                }
                else
                {
                    stmin = sty;
                    stmax = stx;
                }
            }
            else
            {
                stmin = stx;
                stmax = stp+xtrapf*(stp-stx);
            }
            if( stp>stpmax )
            {
                stp = stpmax;
            }
            if( stp<stpmin )
            {
                stp = stpmin;
            }
            if( brackt & (stp<=stmin | stp>=stmax) | nfev>=maxfev-1 | infoc==0 | brackt & stmax-stmin<=xtol*stmax )
            {
                stp = stx;
            }
            for(j=1; j<=n; j++)
            {
                x[j] = wa[j]+stp*s[j+sstart];
            }
            funcgrad(x, ref f, ref g);
            info = 0;
            nfev = nfev+1;
            dg = 0;
            for(j=1; j<=n; j++)
            {
                dg = dg+g[j]*s[j+sstart];
            }
            ftest1 = finit+stp*dgtest;
            if( brackt & (stp<=stmin | stp>=stmax) | infoc==0 )
            {
                info = 6;
            }
            if( stp==stpmax & f<=ftest1 & dg<=dgtest )
            {
                info = 5;
            }
            if( stp==stpmin & (f>ftest1 | dg>=dgtest) )
            {
                info = 4;
            }
            if( nfev>=maxfev )
            {
                info = 3;
            }
            if( brackt & stmax-stmin<=xtol*stmax )
            {
                info = 2;
            }
            if( f<=ftest1 & Math.Abs(dg)<=-(gtol*dginit) )
            {
                info = 1;
            }
            if( info!=0 )
            {
                return;
            }
            mytemp = ftol;
            if( gtol<ftol )
            {
                mytemp = gtol;
            }
            if( stage1 & f<=ftest1 & dg>=mytemp*dginit )
            {
                stage1 = false;
            }
            if( stage1 & f<=fx & f>ftest1 )
            {
                fm = f-stp*dgtest;
                fxm = fx-stx*dgtest;
                fym = fy-sty*dgtest;
                dgm = dg-dgtest;
                dgxm = dgx-dgtest;
                dgym = dgy-dgtest;
                lbfgsmcstep(ref stx, ref fxm, ref dgxm, ref sty, ref fym, ref dgym, ref stp, fm, dgm, ref brackt, stmin, stmax, ref infoc);
                fx = fxm+stx*dgtest;
                fy = fym+sty*dgtest;
                dgx = dgxm+dgtest;
                dgy = dgym+dgtest;
            }
            else
            {
                lbfgsmcstep(ref stx, ref fx, ref dgx, ref sty, ref fy, ref dgy, ref stp, f, dg, ref brackt, stmin, stmax, ref infoc);
            }
            if( brackt )
            {
                if( Math.Abs(sty-stx)>=p66*width1 )
                {
                    stp = stx+p5*(sty-stx);
                }
                width1 = width;
                width = Math.Abs(sty-stx);
            }
        }
    }


    private static void lbfgsmcstep(ref double stx,
        ref double fx,
        ref double dx,
        ref double sty,
        ref double fy,
        ref double dy,
        ref double stp,
        double fp,
        double dp,
        ref bool brackt,
        double stmin,
        double stmax,
        ref int info)
    {
        bool bound = new bool();
        double gamma = 0;
        double p = 0;
        double q = 0;
        double r = 0;
        double s = 0;
        double sgnd = 0;
        double stpc = 0;
        double stpf = 0;
        double stpq = 0;
        double theta = 0;

        info = 0;
        if( brackt & (stp<=Math.Min(stx, sty) | stp>=Math.Max(stx, sty)) | dx*(stp-stx)>=0 | stmax<stmin )
        {
            return;
        }
        sgnd = dp*(dx/Math.Abs(dx));
        if( fp>fx )
        {
            info = 1;
            bound = true;
            theta = 3*(fx-fp)/(stp-stx)+dx+dp;
            s = Math.Max(Math.Abs(theta), Math.Max(Math.Abs(dx), Math.Abs(dp)));
            gamma = s*Math.Sqrt(AP.Math.Sqr(theta/s)-dx/s*(dp/s));
            if( stp<stx )
            {
                gamma = -gamma;
            }
            p = gamma-dx+theta;
            q = gamma-dx+gamma+dp;
            r = p/q;
            stpc = stx+r*(stp-stx);
            stpq = stx+dx/((fx-fp)/(stp-stx)+dx)/2*(stp-stx);
            if( Math.Abs(stpc-stx)<Math.Abs(stpq-stx) )
            {
                stpf = stpc;
            }
            else
            {
                stpf = stpc+(stpq-stpc)/2;
            }
            brackt = true;
        }
        else
        {
            if( sgnd<0 )
            {
                info = 2;
                bound = false;
                theta = 3*(fx-fp)/(stp-stx)+dx+dp;
                s = Math.Max(Math.Abs(theta), Math.Max(Math.Abs(dx), Math.Abs(dp)));
                gamma = s*Math.Sqrt(AP.Math.Sqr(theta/s)-dx/s*(dp/s));
                if( stp>stx )
                {
                    gamma = -gamma;
                }
                p = gamma-dp+theta;
                q = gamma-dp+gamma+dx;
                r = p/q;
                stpc = stp+r*(stx-stp);
                stpq = stp+dp/(dp-dx)*(stx-stp);
                if( Math.Abs(stpc-stp)>Math.Abs(stpq-stp) )
                {
                    stpf = stpc;
                }
                else
                {
                    stpf = stpq;
                }
                brackt = true;
            }
            else
            {
                if( Math.Abs(dp)<Math.Abs(dx) )
                {
                    info = 3;
                    bound = true;
                    theta = 3*(fx-fp)/(stp-stx)+dx+dp;
                    s = Math.Max(Math.Abs(theta), Math.Max(Math.Abs(dx), Math.Abs(dp)));
                    gamma = s*Math.Sqrt(Math.Max(0, AP.Math.Sqr(theta/s)-dx/s*(dp/s)));
                    if( stp>stx )
                    {
                        gamma = -gamma;
                    }
                    p = gamma-dp+theta;
                    q = gamma+(dx-dp)+gamma;
                    r = p/q;
                    if( r<0 & gamma!=0 )
                    {
                        stpc = stp+r*(stx-stp);
                    }
                    else
                    {
                        if( stp>stx )
                        {
                            stpc = stmax;
                        }
                        else
                        {
                            stpc = stmin;
                        }
                    }
                    stpq = stp+dp/(dp-dx)*(stx-stp);
                    if( brackt )
                    {
                        if( Math.Abs(stp-stpc)<Math.Abs(stp-stpq) )
                        {
                            stpf = stpc;
                        }
                        else
                        {
                            stpf = stpq;
                        }
                    }
                    else
                    {
                        if( Math.Abs(stp-stpc)>Math.Abs(stp-stpq) )
                        {
                            stpf = stpc;
                        }
                        else
                        {
                            stpf = stpq;
                        }
                    }
                }
                else
                {
                    info = 4;
                    bound = false;
                    if( brackt )
                    {
                        theta = 3*(fp-fy)/(sty-stp)+dy+dp;
                        s = Math.Max(Math.Abs(theta), Math.Max(Math.Abs(dy), Math.Abs(dp)));
                        gamma = s*Math.Sqrt(AP.Math.Sqr(theta/s)-dy/s*(dp/s));
                        if( stp>sty )
                        {
                            gamma = -gamma;
                        }
                        p = gamma-dp+theta;
                        q = gamma-dp+gamma+dy;
                        r = p/q;
                        stpc = stp+r*(sty-stp);
                        stpf = stpc;
                    }
                    else
                    {
                        if( stp>stx )
                        {
                            stpf = stmax;
                        }
                        else
                        {
                            stpf = stmin;
                        }
                    }
                }
            }
        }
        if( fp>fx )
        {
            sty = stp;
            fy = fp;
            dy = dp;
        }
        else
        {
            if( sgnd<0.0 )
            {
                sty = stx;
                fy = fx;
                dy = dx;
            }
            stx = stp;
            fx = fp;
            dx = dp;
        }
        stpf = Math.Min(stmax, stpf);
        stpf = Math.Max(stmin, stpf);
        stp = stpf;
        if( brackt & bound )
        {
            if( sty>stx )
            {
                stp = Math.Min(stx+0.66*(sty-stx), stp);
            }
            else
            {
                stp = Math.Max(stx+0.66*(sty-stx), stp);
            }
        }
    }


    private static void lbfgsnewiteration(ref double[] x,
        double f,
        ref double[] g)
    {
    }
}
