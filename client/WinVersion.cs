using System;
using System.Runtime.InteropServices;
using System.Security;

namespace client
{
    public struct VersionInfo
    {
        public int Major;
        public int Minor;
        public int BuildNum;
    }

    public class WinVersion
    {
        [SecurityCritical]
        [DllImport("ntdll.dll", SetLastError = true)]
        internal static extern int RtlGetVersion(ref OSVERSIONINFOEX versionInfo);
        [StructLayout(LayoutKind.Sequential)]
        internal struct OSVERSIONINFOEX
        {
            // The OSVersionInfoSize field must be set to Marshal.SizeOf(typeof(OSVERSIONINFOEX))
            internal int OSVersionInfoSize;
            internal int MajorVersion;
            internal int MinorVersion;
            internal int BuildNumber;
            internal int PlatformId;
            [MarshalAs(UnmanagedType.ByValTStr, SizeConst = 128)]
            internal string CSDVersion;
            internal ushort ServicePackMajor;
            internal ushort ServicePackMinor;
            internal short SuiteMask;
            internal byte ProductType;
            internal byte Reserved;
        }

        public static bool GetVersion(out VersionInfo info)
        {
            info.Major = 0;
            info.Minor = 0;
            info.BuildNum = 0;
            OSVERSIONINFOEX osv = new OSVERSIONINFOEX { OSVersionInfoSize = Marshal.SizeOf(typeof(OSVERSIONINFOEX)) };
            if (RtlGetVersion(ref osv) == 0)
            {
                info.Major = osv.MajorVersion;
                info.Minor = osv.MinorVersion;
                info.BuildNum = osv.BuildNumber;
                if (osv.BuildNumber >= 22000)
                    info.Major = 11;
                return true;
            }
            return false;
        }
    }
}
