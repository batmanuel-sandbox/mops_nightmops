"""
Class to represent an Orbit object (part of a MovingObject instance).
"""
from DayMOPSObject import DayMOPSObject



# Constants
STABLE_STATUS = {'STABLE':      'Y',
                 'UNSTABLE':    'N'}


class Orbit(DayMOPSObject):
    """
    Representation of an Orbit.
    
    This, together with the MovingObject class, fully describe the subset of the
    MovingObject table of interset to MOPS.
    """
    def __init__(self, 
                 q=None, 
                 e=None, 
                 i=None, 
                 node=None, 
                 argPeri=None, 
                 m=None,
                 timePeri=None, 
                 epoch=None, 
                 src=[],
                 orbFitResidual=None,
                 orbFitChi2=None,
                 classification=None,
                 stablePass=STABLE_STATUS['UNSTABLE'],
                 moid1=None,
                 moid2=None,
                 moidLong1=None,
                 moidLong2=None):
        """
        a (AU)                              (only for Keplerian elements)
        q (AU)                              (only for cometary elements)
        e
        i (deg)
        node (deg)
        argPeri (deg)
        m (deg)                             (only for Keplerian elements)
        timePeri (TAI MJD)                  (only for cometary elements)
        epoch: orbit epoch (TAI MJD)
        src: 21 element array (covariance matrix in diagonal form).
        """
        super(Orbit, self).__init__()
        
        self._q = q
        self._e = e
        self._i = i
        self._node = node
        self._argPeri = argPeri
        self._m = m
        self._timePeri = timePeri
        self._epoch = epoch
        self._src = None
        self.setSrc(src)
        
        self._orbFitResidual = orbFitResidual
        self._orbFitChi2 = orbFitChi2
        self._classification = classification
        self._stablePass = stablePass
        self._moid1 = moid1
        self._moid2 = moid2
        self._moidLong1 = moidLong1
        self._moidLong2 = moidLong2
        return

    def __str__(self):
        return('(%s, %s,%s, %s, %s, %s, %s, %s, %s)'\
               % tuple([str(x) for x in (self._q, self._e, self._i, self._node, 
                        self._m, self._timePeri, self._argPeri, self._epoch)]))

    def setSrc(self, src):
        """
        If all elements of the covariance list are not None, then cast that
        list into a numpy.array. Return the casted array or None in case the
        covariance is invalid (i.e. has null elements).
        """
        self._src = []
        if(not None in src):
            self._src = [float(e) for e in src]
        return




