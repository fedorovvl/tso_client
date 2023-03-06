using System;
using System.Runtime.InteropServices;

namespace client
{
    public struct VersionInfo
    {
        public uint Major;
        public uint Minor;
        public uint BuildNum;
    }

    public class WinVersion
    {
        [StructLayout(LayoutKind.Sequential, CharSet = CharSet.Unicode)]
        public struct OSVERSIONINFOEXW
        {
            public uint dwOSVersionInfoSize;
            public uint dwMajorVersion;
            public uint dwMinorVersion;
            public uint dwBuildNumber;
            public uint dwPlatformId;
            [MarshalAs(UnmanagedType.LPWStr, SizeConst = 128)]
            public string szCSDVersion;
            public UInt16 wServicePackMajor;
            public UInt16 wServicePackMinor;
            public UInt16 wSuiteMask;
            public byte wProductType;
            public byte wReserved;
        }
        [DllImport("ntdll.dll", CallingConvention = CallingConvention.StdCall)]
        public static extern int RtlGetVersion(out OSVERSIONINFOEXW osv);

        public static bool GetVersion(out VersionInfo info)
        {
            info.Major = 0;
            info.Minor = 0;
            info.BuildNum = 0;
            OSVERSIONINFOEXW osv = new OSVERSIONINFOEXW();
            osv.dwOSVersionInfoSize = 284;
            if (RtlGetVersion(out osv) == 0)
            {
                info.Major = osv.dwMajorVersion;
                info.Minor = osv.dwMinorVersion;
                info.BuildNum = osv.dwBuildNumber;
                if (osv.dwBuildNumber >= 22000)
                    info.Major = 11;
                return true;
            }
            return false;
        }
    }
}
