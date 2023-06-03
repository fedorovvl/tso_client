.class Lcom/adobe/air/OrientationManager;
.super Ljava/lang/Object;
.source "OrientationManager.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/adobe/air/OrientationManager$EAspectRatio;,
        Lcom/adobe/air/OrientationManager$EDefault;,
        Lcom/adobe/air/OrientationManager$EOrientation;
    }
.end annotation


# static fields
.field private static final AIR_NAMESPACE_VERSION_3_3:F = 3.3f

.field private static final AIR_NAMESPACE_VERSION_3_8:F = 3.8f

.field private static final LOG_TAG:Ljava/lang/String; = "OrientationManager"

.field private static sMgr:Lcom/adobe/air/OrientationManager;


# instance fields
.field public mAfterOrientation:I

.field private mAutoOrients:Z

.field public mBeforeOrientation:I

.field private mDeviceDefault:I

.field private mDeviceOrientation:I

.field public mDispatchOrientationChangePending:Z

.field private mFinalOrientation:I

.field private mFirstCreate:Z

.field private mHardKeyboardHidden:I

.field private mNamespaceVersion:F

.field private mOldDeviceOrientation:I

.field private mOrientation:I

.field private mOrientationEventListner:Landroid/view/OrientationEventListener;

.field private mOsDefaultOrientation:I

.field private mOsReversedOrientation:I

.field private mOsRotatedLeftOrientation:I

.field private mOsRotatedRightOrientation:I

.field private mRequestedAspectRatio:I

.field private mSetOrientation:Z

.field private mView:Lcom/adobe/air/AIRWindowSurfaceView;

.field private m_activity:Landroid/app/Activity;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 41
    const/4 v0, 0x0

    sput-object v0, Lcom/adobe/air/OrientationManager;->sMgr:Lcom/adobe/air/OrientationManager;

    return-void
.end method

.method private constructor <init>()V
    .locals 4

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    const/4 v1, 0x0

    .line 76
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 42
    iput-boolean v2, p0, Lcom/adobe/air/OrientationManager;->mFirstCreate:Z

    .line 46
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 48
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    .line 49
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mOldDeviceOrientation:I

    .line 50
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mFinalOrientation:I

    .line 51
    sget-object v0, Lcom/adobe/air/OrientationManager$EDefault;->PORTRAIT:Lcom/adobe/air/OrientationManager$EDefault;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EDefault;->ordinal()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mDeviceDefault:I

    .line 52
    iput-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    .line 53
    iput-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    .line 54
    const/4 v0, 0x2

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mHardKeyboardHidden:I

    .line 56
    iput-object v3, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    .line 57
    iput-object v3, p0, Lcom/adobe/air/OrientationManager;->mView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 59
    iput v2, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    .line 60
    iput v1, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedRightOrientation:I

    .line 61
    const/16 v0, 0x8

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedLeftOrientation:I

    .line 62
    const/16 v0, 0x9

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mOsReversedOrientation:I

    .line 66
    iput-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mDispatchOrientationChangePending:Z

    .line 70
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    .line 77
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/OrientationManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    return v0
.end method

.method static synthetic access$002(Lcom/adobe/air/OrientationManager;I)I
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;
    .param p1, "x1"    # I

    .prologue
    .line 38
    iput p1, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    return p1
.end method

.method static synthetic access$100(Lcom/adobe/air/OrientationManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    iget-boolean v0, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    return v0
.end method

.method static synthetic access$200(Lcom/adobe/air/OrientationManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mOldDeviceOrientation:I

    return v0
.end method

.method static synthetic access$202(Lcom/adobe/air/OrientationManager;I)I
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;
    .param p1, "x1"    # I

    .prologue
    .line 38
    iput p1, p0, Lcom/adobe/air/OrientationManager;->mOldDeviceOrientation:I

    return p1
.end method

.method static synthetic access$300(Lcom/adobe/air/OrientationManager;)I
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    return v0
.end method

.method static synthetic access$302(Lcom/adobe/air/OrientationManager;I)I
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;
    .param p1, "x1"    # I

    .prologue
    .line 38
    iput p1, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    return p1
.end method

.method static synthetic access$400(Lcom/adobe/air/OrientationManager;)Landroid/app/Activity;
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    return-object v0
.end method

.method static synthetic access$500(Lcom/adobe/air/OrientationManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->isReOrientingAllowed()Z

    move-result v0

    return v0
.end method

.method static synthetic access$600(Lcom/adobe/air/OrientationManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->setSensorBasedOrientation()Z

    move-result v0

    return v0
.end method

.method static synthetic access$702(Lcom/adobe/air/OrientationManager;I)I
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;
    .param p1, "x1"    # I

    .prologue
    .line 38
    iput p1, p0, Lcom/adobe/air/OrientationManager;->mFinalOrientation:I

    return p1
.end method

.method static synthetic access$800(Lcom/adobe/air/OrientationManager;)Z
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    iget-boolean v0, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    return v0
.end method

.method static synthetic access$802(Lcom/adobe/air/OrientationManager;Z)Z
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;
    .param p1, "x1"    # Z

    .prologue
    .line 38
    iput-boolean p1, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    return p1
.end method

.method static synthetic access$900(Lcom/adobe/air/OrientationManager;)F
    .locals 1
    .param p0, "x0"    # Lcom/adobe/air/OrientationManager;

    .prologue
    .line 38
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    return v0
.end method

.method private applyLastOrientation()V
    .locals 5

    .prologue
    const v4, 0x40533333    # 3.3f

    const/4 v3, 0x1

    .line 752
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    if-nez v1, :cond_3

    .line 754
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    if-eq v1, v3, :cond_0

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    cmpl-float v1, v1, v4

    if-ltz v1, :cond_2

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    const/4 v2, -0x1

    if-eq v1, v2, :cond_2

    .line 757
    :cond_0
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    invoke-virtual {p0, v1}, Lcom/adobe/air/OrientationManager;->setOrientation(I)V

    .line 813
    :cond_1
    :goto_0
    return-void

    .line 761
    :cond_2
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    invoke-virtual {p0, v1}, Lcom/adobe/air/OrientationManager;->setAutoOrients(Z)V

    goto :goto_0

    .line 770
    :cond_3
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    if-ne v1, v3, :cond_4

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOldDeviceOrientation:I

    iget v2, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    if-ne v1, v2, :cond_4

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    cmpl-float v1, v1, v4

    if-gez v1, :cond_1

    .line 776
    :cond_4
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    invoke-virtual {p0, v1}, Lcom/adobe/air/OrientationManager;->setAutoOrients(Z)V

    .line 778
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->getCurrentOrientation()I

    move-result v1

    iput v1, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    .line 779
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    iput v1, p0, Lcom/adobe/air/OrientationManager;->mBeforeOrientation:I

    .line 782
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mBeforeOrientation:I

    iget v2, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    if-eq v1, v2, :cond_1

    .line 784
    const/4 v0, 0x0

    .line 785
    .local v0, "eventCancelled":Z
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/AndroidActivityWrapper;->isApplicationLaunched()Z

    move-result v1

    if-eqz v1, :cond_5

    .line 787
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mBeforeOrientation:I

    iget v2, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    invoke-virtual {p0, v1, v2}, Lcom/adobe/air/OrientationManager;->nativeOrientationChanging(II)Z

    move-result v0

    .line 789
    :cond_5
    if-eqz v0, :cond_6

    .line 791
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mBeforeOrientation:I

    invoke-virtual {p0, v1}, Lcom/adobe/air/OrientationManager;->setNearestOrientation(I)V

    goto :goto_0

    .line 795
    :cond_6
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    iput v1, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 797
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v1

    invoke-virtual {v1}, Lcom/adobe/air/AndroidActivityWrapper;->isApplicationLaunched()Z

    move-result v1

    if-eqz v1, :cond_1

    .line 800
    iget-object v1, p0, Lcom/adobe/air/OrientationManager;->mView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Lcom/adobe/air/AIRWindowSurfaceView;->getVisibleBoundHeight()I

    move-result v1

    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->mView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v2}, Lcom/adobe/air/AIRWindowSurfaceView;->getVisibleBoundWidth()I

    move-result v2

    if-ne v1, v2, :cond_7

    .line 802
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mBeforeOrientation:I

    iget v2, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    invoke-virtual {p0, v1, v2}, Lcom/adobe/air/OrientationManager;->nativeOrientationChanged(II)V

    .line 803
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mDispatchOrientationChangePending:Z

    goto :goto_0

    .line 807
    :cond_7
    iput-boolean v3, p0, Lcom/adobe/air/OrientationManager;->mDispatchOrientationChangePending:Z

    goto :goto_0
.end method

.method private getCurrentOrientation()I
    .locals 4

    .prologue
    .line 621
    sget-object v3, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v3}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    .line 623
    .local v0, "currentOrientation":I
    iget-object v3, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    if-nez v3, :cond_0

    move v1, v0

    .line 645
    .end local v0    # "currentOrientation":I
    .local v1, "currentOrientation":I
    :goto_0
    return v1

    .line 626
    .end local v1    # "currentOrientation":I
    .restart local v0    # "currentOrientation":I
    :cond_0
    iget-object v3, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v3}, Landroid/app/Activity;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v3

    invoke-interface {v3}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v3

    invoke-virtual {v3}, Landroid/view/Display;->getRotation()I

    move-result v2

    .line 628
    .local v2, "orientation":I
    if-nez v2, :cond_2

    .line 630
    sget-object v3, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v3}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    :cond_1
    :goto_1
    move v1, v0

    .line 645
    .end local v0    # "currentOrientation":I
    .restart local v1    # "currentOrientation":I
    goto :goto_0

    .line 632
    .end local v1    # "currentOrientation":I
    .restart local v0    # "currentOrientation":I
    :cond_2
    const/4 v3, 0x1

    if-ne v2, v3, :cond_3

    .line 634
    sget-object v3, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v3}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    goto :goto_1

    .line 636
    :cond_3
    const/4 v3, 0x2

    if-ne v2, v3, :cond_4

    .line 638
    sget-object v3, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v3}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    goto :goto_1

    .line 640
    :cond_4
    const/4 v3, 0x3

    if-ne v2, v3, :cond_1

    .line 642
    sget-object v3, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v3}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    goto :goto_1
.end method

.method public static getOrientationManager()Lcom/adobe/air/OrientationManager;
    .locals 1

    .prologue
    .line 81
    sget-object v0, Lcom/adobe/air/OrientationManager;->sMgr:Lcom/adobe/air/OrientationManager;

    if-nez v0, :cond_0

    .line 82
    new-instance v0, Lcom/adobe/air/OrientationManager;

    invoke-direct {v0}, Lcom/adobe/air/OrientationManager;-><init>()V

    sput-object v0, Lcom/adobe/air/OrientationManager;->sMgr:Lcom/adobe/air/OrientationManager;

    .line 84
    :cond_0
    sget-object v0, Lcom/adobe/air/OrientationManager;->sMgr:Lcom/adobe/air/OrientationManager;

    return-object v0
.end method

.method private isReOrientingAllowed()Z
    .locals 3

    .prologue
    .line 93
    const/4 v0, 0x0

    .line 95
    .local v0, "bReorientingAllowed":Z
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    const v2, 0x40533333    # 3.3f

    cmpl-float v1, v1, v2

    if-ltz v1, :cond_6

    .line 97
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    const/4 v2, 0x1

    if-ne v1, v2, :cond_2

    .line 99
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    const/4 v2, -0x1

    if-eq v1, v2, :cond_5

    .line 101
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mFirstCreate:Z

    if-eqz v1, :cond_0

    .line 102
    const/4 v0, 0x1

    .line 104
    :cond_0
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    iget v2, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-ne v1, v2, :cond_3

    .line 106
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    sget-object v2, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v2}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v2

    if-eq v1, v2, :cond_1

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    sget-object v2, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    .line 107
    invoke-virtual {v2}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v2

    if-ne v1, v2, :cond_2

    .line 109
    :cond_1
    const/4 v0, 0x1

    .line 133
    :cond_2
    :goto_0
    return v0

    .line 113
    :cond_3
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    sget-object v2, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v2}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v2

    if-eq v1, v2, :cond_4

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    sget-object v2, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    .line 114
    invoke-virtual {v2}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v2

    if-ne v1, v2, :cond_2

    .line 116
    :cond_4
    const/4 v0, 0x1

    goto :goto_0

    .line 121
    :cond_5
    const/4 v0, 0x1

    goto :goto_0

    .line 128
    :cond_6
    const/4 v0, 0x1

    goto :goto_0
.end method

.method private setDeviceDefault()V
    .locals 11

    .prologue
    const/16 v10, 0x9

    const/16 v9, 0x8

    const/4 v7, 0x1

    const/4 v6, 0x0

    .line 653
    iget-object v8, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v8}, Landroid/app/Activity;->getWindow()Landroid/view/Window;

    move-result-object v8

    invoke-virtual {v8}, Landroid/view/Window;->getWindowManager()Landroid/view/WindowManager;

    move-result-object v8

    invoke-interface {v8}, Landroid/view/WindowManager;->getDefaultDisplay()Landroid/view/Display;

    move-result-object v2

    .line 654
    .local v2, "display":Landroid/view/Display;
    invoke-virtual {v2}, Landroid/view/Display;->getRotation()I

    move-result v4

    .line 655
    .local v4, "rotation":I
    invoke-virtual {v2}, Landroid/view/Display;->getHeight()I

    move-result v3

    .line 656
    .local v3, "height":I
    invoke-virtual {v2}, Landroid/view/Display;->getWidth()I

    move-result v5

    .line 657
    .local v5, "width":I
    if-lt v3, v5, :cond_3

    move v1, v7

    .line 658
    .local v1, "currentlyPortrait":Z
    :goto_0
    if-eqz v4, :cond_0

    const/4 v8, 0x2

    if-ne v4, v8, :cond_4

    :cond_0
    move v0, v7

    .line 659
    .local v0, "atDefaultAspectRatio":Z
    :goto_1
    if-eqz v1, :cond_1

    if-nez v0, :cond_2

    :cond_1
    if-nez v1, :cond_6

    if-nez v0, :cond_6

    .line 661
    :cond_2
    iput v7, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    .line 662
    iput v6, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedRightOrientation:I

    .line 663
    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    if-gt v6, v9, :cond_5

    .line 665
    iget v6, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedRightOrientation:I

    iput v6, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedLeftOrientation:I

    .line 666
    iget v6, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    iput v6, p0, Lcom/adobe/air/OrientationManager;->mOsReversedOrientation:I

    .line 689
    :goto_2
    return-void

    .end local v0    # "atDefaultAspectRatio":Z
    .end local v1    # "currentlyPortrait":Z
    :cond_3
    move v1, v6

    .line 657
    goto :goto_0

    .restart local v1    # "currentlyPortrait":Z
    :cond_4
    move v0, v6

    .line 658
    goto :goto_1

    .line 670
    .restart local v0    # "atDefaultAspectRatio":Z
    :cond_5
    iput v9, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedLeftOrientation:I

    .line 671
    iput v10, p0, Lcom/adobe/air/OrientationManager;->mOsReversedOrientation:I

    goto :goto_2

    .line 676
    :cond_6
    iput v6, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    .line 677
    iput v7, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedLeftOrientation:I

    .line 678
    sget v6, Landroid/os/Build$VERSION;->SDK_INT:I

    if-gt v6, v9, :cond_7

    .line 680
    iget v6, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedLeftOrientation:I

    iput v6, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedRightOrientation:I

    .line 681
    iget v6, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    iput v6, p0, Lcom/adobe/air/OrientationManager;->mOsReversedOrientation:I

    goto :goto_2

    .line 685
    :cond_7
    iput v10, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedRightOrientation:I

    .line 686
    iput v9, p0, Lcom/adobe/air/OrientationManager;->mOsReversedOrientation:I

    goto :goto_2
.end method

.method private setOrientationParamsFromMetaData()V
    .locals 8

    .prologue
    const v7, 0x40733333    # 3.8f

    .line 696
    :try_start_0
    iget-object v4, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v4}, Landroid/app/Activity;->getPackageManager()Landroid/content/pm/PackageManager;

    move-result-object v4

    iget-object v5, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v5}, Landroid/app/Activity;->getComponentName()Landroid/content/ComponentName;

    move-result-object v5

    const/16 v6, 0x80

    invoke-virtual {v4, v5, v6}, Landroid/content/pm/PackageManager;->getActivityInfo(Landroid/content/ComponentName;I)Landroid/content/pm/ActivityInfo;

    move-result-object v0

    .line 697
    .local v0, "actInfo":Landroid/content/pm/ActivityInfo;
    iget-object v3, v0, Landroid/content/pm/ActivityInfo;->metaData:Landroid/os/Bundle;

    .line 700
    .local v3, "bundle":Landroid/os/Bundle;
    if-nez v3, :cond_1

    .line 747
    .end local v0    # "actInfo":Landroid/content/pm/ActivityInfo;
    .end local v3    # "bundle":Landroid/os/Bundle;
    :cond_0
    :goto_0
    return-void

    .line 703
    .restart local v0    # "actInfo":Landroid/content/pm/ActivityInfo;
    .restart local v3    # "bundle":Landroid/os/Bundle;
    :cond_1
    const-string v4, "autoOrients"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/Boolean;

    .line 704
    .local v2, "autoOrients":Ljava/lang/Boolean;
    const-string v4, "aspectRatio"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->get(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    .line 711
    .local v1, "aspectRatio":Ljava/lang/String;
    const-string v4, "namespaceVersion"

    invoke-virtual {v3, v4}, Landroid/os/Bundle;->getFloat(Ljava/lang/String;)F

    move-result v4

    iput v4, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    .line 715
    if-eqz v1, :cond_2

    .line 717
    const-string v4, "portrait"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_3

    .line 719
    sget-object v4, Lcom/adobe/air/OrientationManager$EAspectRatio;->PORTRAIT:Lcom/adobe/air/OrientationManager$EAspectRatio;

    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EAspectRatio;->ordinal()I

    move-result v4

    invoke-virtual {p0, v4}, Lcom/adobe/air/OrientationManager;->setAspectRatio(I)V

    .line 727
    :cond_2
    :goto_1
    if-eqz v2, :cond_4

    invoke-virtual {v2}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v4

    if-eqz v4, :cond_4

    .line 729
    const/4 v4, 0x1

    invoke-virtual {p0, v4}, Lcom/adobe/air/OrientationManager;->setAutoOrients(Z)V

    goto :goto_0

    .line 743
    .end local v0    # "actInfo":Landroid/content/pm/ActivityInfo;
    .end local v1    # "aspectRatio":Ljava/lang/String;
    .end local v2    # "autoOrients":Ljava/lang/Boolean;
    .end local v3    # "bundle":Landroid/os/Bundle;
    :catch_0
    move-exception v4

    goto :goto_0

    .line 721
    .restart local v0    # "actInfo":Landroid/content/pm/ActivityInfo;
    .restart local v1    # "aspectRatio":Ljava/lang/String;
    .restart local v2    # "autoOrients":Ljava/lang/Boolean;
    .restart local v3    # "bundle":Landroid/os/Bundle;
    :cond_3
    const-string v4, "landscape"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_2

    .line 723
    sget-object v4, Lcom/adobe/air/OrientationManager$EAspectRatio;->LANDSCAPE:Lcom/adobe/air/OrientationManager$EAspectRatio;

    invoke-virtual {v4}, Lcom/adobe/air/OrientationManager$EAspectRatio;->ordinal()I

    move-result v4

    invoke-virtual {p0, v4}, Lcom/adobe/air/OrientationManager;->setAspectRatio(I)V

    goto :goto_1

    .line 733
    :cond_4
    iget v4, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    cmpl-float v4, v4, v7

    if-ltz v4, :cond_6

    if-eqz v1, :cond_5

    const-string v4, "any"

    invoke-virtual {v1, v4}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result v4

    if-eqz v4, :cond_6

    .line 735
    :cond_5
    const/4 v4, 0x0

    invoke-virtual {p0, v4}, Lcom/adobe/air/OrientationManager;->setAutoOrients(Z)V

    goto :goto_0

    .line 737
    :cond_6
    iget v4, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    cmpg-float v4, v4, v7

    if-gtz v4, :cond_0

    if-nez v1, :cond_0

    .line 739
    const/4 v4, 0x0

    invoke-virtual {p0, v4}, Lcom/adobe/air/OrientationManager;->setAutoOrients(Z)V
    :try_end_0
    .catch Landroid/content/pm/PackageManager$NameNotFoundException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0
.end method

.method private setSensorBasedOrientation()Z
    .locals 9

    .prologue
    const/4 v5, 0x0

    const v8, 0x40533333    # 3.3f

    const/4 v4, 0x1

    .line 143
    iget v2, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 144
    .local v2, "beforeOrientation":I
    const/4 v1, 0x0

    .line 145
    .local v1, "bOrientationChanged":Z
    iget v6, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    const/4 v7, -0x1

    if-eq v6, v7, :cond_2

    move v0, v4

    .line 147
    .local v0, "bAspectRatioSet":Z
    :goto_0
    iget-boolean v6, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    if-ne v6, v4, :cond_1

    .line 149
    iget-boolean v6, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    if-ne v6, v4, :cond_0

    iget v6, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    cmpl-float v6, v6, v8

    if-ltz v6, :cond_0

    .line 150
    iput-boolean v5, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    .line 152
    :cond_0
    if-eqz v0, :cond_8

    iget v5, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    cmpl-float v5, v5, v8

    if-ltz v5, :cond_8

    .line 159
    iget v5, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    iget v6, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-ne v5, v6, :cond_4

    .line 161
    iget v4, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    if-ne v4, v5, :cond_3

    .line 163
    iget-object v4, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    iget v5, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    invoke-virtual {v4, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 164
    const/4 v1, 0x1

    .line 205
    :cond_1
    :goto_1
    return v1

    .end local v0    # "bAspectRatioSet":Z
    :cond_2
    move v0, v5

    .line 145
    goto :goto_0

    .line 166
    .restart local v0    # "bAspectRatioSet":Z
    :cond_3
    iget v4, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v5

    if-ne v4, v5, :cond_1

    .line 168
    iget-object v4, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    iget v5, p0, Lcom/adobe/air/OrientationManager;->mOsReversedOrientation:I

    invoke-virtual {v4, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 169
    const/4 v1, 0x1

    goto :goto_1

    .line 175
    :cond_4
    iget v5, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-ne v5, v4, :cond_5

    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v3

    .line 177
    .local v3, "orientation":I
    :goto_2
    const/4 v1, 0x1

    .line 178
    iget v5, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    if-ne v5, v3, :cond_6

    .line 180
    iget-object v4, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    iget v5, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    invoke-virtual {v4, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_1

    .line 175
    .end local v3    # "orientation":I
    :cond_5
    sget-object v5, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v5}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v3

    goto :goto_2

    .line 184
    .restart local v3    # "orientation":I
    :cond_6
    iget v5, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-ne v5, v4, :cond_7

    .line 186
    iget-object v4, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    const/16 v5, 0x8

    invoke-virtual {v4, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_1

    .line 190
    :cond_7
    iget-object v4, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    const/16 v5, 0x9

    invoke-virtual {v4, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_1

    .line 199
    .end local v3    # "orientation":I
    :cond_8
    iget-object v4, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    const/4 v5, 0x2

    invoke-virtual {v4, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 200
    const/4 v1, 0x1

    goto :goto_1
.end method


# virtual methods
.method public enableEventListener(Z)V
    .locals 1
    .param p1, "enable"    # Z

    .prologue
    .line 343
    if-eqz p1, :cond_0

    .line 344
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->mOrientationEventListner:Landroid/view/OrientationEventListener;

    invoke-virtual {v0}, Landroid/view/OrientationEventListener;->enable()V

    .line 347
    :goto_0
    return-void

    .line 346
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->mOrientationEventListner:Landroid/view/OrientationEventListener;

    invoke-virtual {v0}, Landroid/view/OrientationEventListener;->disable()V

    goto :goto_0
.end method

.method public getAutoOrients()Z
    .locals 1

    .prologue
    .line 583
    iget-boolean v0, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    return v0
.end method

.method public getDeviceOrientation()I
    .locals 2

    .prologue
    const/4 v1, 0x1

    .line 412
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mHardKeyboardHidden:I

    if-ne v0, v1, :cond_1

    .line 414
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-ne v0, v1, :cond_0

    .line 416
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    .line 425
    :goto_0
    return v0

    .line 420
    :cond_0
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    goto :goto_0

    .line 425
    :cond_1
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mDeviceOrientation:I

    goto :goto_0
.end method

.method public getOrientation()I
    .locals 1

    .prologue
    .line 403
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->getCurrentOrientation()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 404
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    return v0
.end method

.method public getSupportedOrientations()[I
    .locals 6

    .prologue
    const/4 v5, 0x2

    const/4 v4, 0x0

    const/4 v3, 0x1

    .line 589
    const/4 v0, 0x0

    .line 590
    .local v0, "supportedOrientations":[I
    sget v1, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v2, 0x8

    if-gt v1, v2, :cond_1

    .line 592
    new-array v0, v5, [I

    .line 594
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-ne v1, v3, :cond_0

    .line 596
    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v1}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v1

    aput v1, v0, v4

    .line 597
    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v1}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v1

    aput v1, v0, v3

    .line 614
    :goto_0
    return-object v0

    .line 601
    :cond_0
    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v1}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v1

    aput v1, v0, v4

    .line 602
    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v1}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v1

    aput v1, v0, v3

    goto :goto_0

    .line 607
    :cond_1
    const/4 v1, 0x4

    new-array v0, v1, [I

    .line 608
    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v1}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v1

    aput v1, v0, v4

    .line 609
    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v1}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v1

    aput v1, v0, v3

    .line 610
    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v1}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v1

    aput v1, v0, v5

    .line 611
    const/4 v1, 0x3

    sget-object v2, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v2}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v2

    aput v2, v0, v1

    goto :goto_0
.end method

.method public native nativeOrientationChanged(II)V
.end method

.method public native nativeOrientationChanging(II)Z
.end method

.method public onActivityCreated(Landroid/app/Activity;Lcom/adobe/air/AIRWindowSurfaceView;)V
    .locals 5
    .param p1, "act"    # Landroid/app/Activity;
    .param p2, "view"    # Lcom/adobe/air/AIRWindowSurfaceView;

    .prologue
    const/4 v4, 0x1

    .line 211
    iput-object p1, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    .line 212
    iput-object p2, p0, Lcom/adobe/air/OrientationManager;->mView:Lcom/adobe/air/AIRWindowSurfaceView;

    .line 215
    iget-object v1, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v1}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v1

    invoke-virtual {v1}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v1

    iget v1, v1, Landroid/content/res/Configuration;->hardKeyboardHidden:I

    iput v1, p0, Lcom/adobe/air/OrientationManager;->mHardKeyboardHidden:I

    .line 218
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mFirstCreate:Z

    if-ne v1, v4, :cond_0

    .line 220
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->setDeviceDefault()V

    .line 221
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->setOrientationParamsFromMetaData()V

    .line 224
    :cond_0
    new-instance v1, Lcom/adobe/air/OrientationManager$1;

    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2}, Landroid/app/Activity;->getApplicationContext()Landroid/content/Context;

    move-result-object v2

    const/4 v3, 0x3

    invoke-direct {v1, p0, v2, v3}, Lcom/adobe/air/OrientationManager$1;-><init>(Lcom/adobe/air/OrientationManager;Landroid/content/Context;I)V

    iput-object v1, p0, Lcom/adobe/air/OrientationManager;->mOrientationEventListner:Landroid/view/OrientationEventListener;

    .line 310
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    .line 311
    .local v0, "actWrapper":Lcom/adobe/air/AndroidActivityWrapper;
    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->isScreenOn()Z

    move-result v1

    if-ne v1, v4, :cond_2

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->isScreenLocked()Z

    move-result v1

    if-nez v1, :cond_2

    .line 314
    iget-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mFirstCreate:Z

    if-nez v1, :cond_1

    .line 316
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->applyLastOrientation()V

    .line 319
    :cond_1
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->getCurrentOrientation()I

    move-result v1

    iput v1, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 322
    :cond_2
    const/4 v1, 0x0

    iput-boolean v1, p0, Lcom/adobe/air/OrientationManager;->mFirstCreate:Z

    .line 324
    return-void
.end method

.method public onActivityDestroyed()V
    .locals 1

    .prologue
    .line 328
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    .line 329
    return-void
.end method

.method public onActivityPaused()V
    .locals 1

    .prologue
    .line 338
    const/4 v0, 0x0

    invoke-virtual {p0, v0}, Lcom/adobe/air/OrientationManager;->enableEventListener(Z)V

    .line 339
    return-void
.end method

.method public onActivityResumed()V
    .locals 1

    .prologue
    .line 333
    const/4 v0, 0x1

    invoke-virtual {p0, v0}, Lcom/adobe/air/OrientationManager;->enableEventListener(Z)V

    .line 334
    return-void
.end method

.method public onConfigurationChanged(Landroid/content/res/Configuration;)V
    .locals 4
    .param p1, "newConfig"    # Landroid/content/res/Configuration;

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 352
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->getCurrentOrientation()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    .line 353
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mBeforeOrientation:I

    .line 360
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mHardKeyboardHidden:I

    iget v1, p1, Landroid/content/res/Configuration;->hardKeyboardHidden:I

    if-eq v0, v1, :cond_1

    .line 362
    iget v0, p1, Landroid/content/res/Configuration;->hardKeyboardHidden:I

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mHardKeyboardHidden:I

    .line 363
    iget-boolean v0, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    if-ne v0, v2, :cond_1

    iget-boolean v0, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    if-ne v0, v2, :cond_1

    .line 365
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 366
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 367
    :cond_0
    iput-boolean v3, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    .line 371
    :cond_1
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mBeforeOrientation:I

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    if-eq v0, v1, :cond_2

    .line 376
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mFinalOrientation:I

    sget-object v1, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v1}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v1

    if-eq v0, v1, :cond_3

    iget v0, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mFinalOrientation:I

    if-eq v0, v1, :cond_3

    .line 398
    :cond_2
    :goto_0
    return-void

    .line 380
    :cond_3
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->UNKNOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mFinalOrientation:I

    .line 382
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 384
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v0

    invoke-virtual {v0}, Lcom/adobe/air/AndroidActivityWrapper;->isApplicationLaunched()Z

    move-result v0

    if-eqz v0, :cond_2

    .line 387
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->mView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v0}, Lcom/adobe/air/AIRWindowSurfaceView;->getVisibleBoundHeight()I

    move-result v0

    iget-object v1, p0, Lcom/adobe/air/OrientationManager;->mView:Lcom/adobe/air/AIRWindowSurfaceView;

    invoke-virtual {v1}, Lcom/adobe/air/AIRWindowSurfaceView;->getVisibleBoundWidth()I

    move-result v1

    if-ne v0, v1, :cond_4

    .line 389
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mBeforeOrientation:I

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mAfterOrientation:I

    invoke-virtual {p0, v0, v1}, Lcom/adobe/air/OrientationManager;->nativeOrientationChanged(II)V

    .line 390
    iput-boolean v3, p0, Lcom/adobe/air/OrientationManager;->mDispatchOrientationChangePending:Z

    goto :goto_0

    .line 394
    :cond_4
    iput-boolean v2, p0, Lcom/adobe/air/OrientationManager;->mDispatchOrientationChangePending:Z

    goto :goto_0
.end method

.method public setAspectRatio(I)V
    .locals 4
    .param p1, "aspectRatio"    # I

    .prologue
    const/4 v3, 0x0

    const/4 v2, 0x1

    .line 519
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_2

    .line 523
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    const v1, 0x40533333    # 3.3f

    cmpg-float v0, v0, v1

    if-gez v0, :cond_0

    .line 524
    iput-boolean v2, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    .line 526
    :cond_0
    sget-object v0, Lcom/adobe/air/OrientationManager$EAspectRatio;->PORTRAIT:Lcom/adobe/air/OrientationManager$EAspectRatio;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EAspectRatio;->ordinal()I

    move-result v0

    if-ne p1, v0, :cond_3

    .line 528
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0, v2}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 529
    iput v2, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    .line 551
    :cond_1
    :goto_0
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->getCurrentOrientation()I

    move-result v0

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 554
    :cond_2
    return-void

    .line 531
    :cond_3
    sget-object v0, Lcom/adobe/air/OrientationManager$EAspectRatio;->LANDSCAPE:Lcom/adobe/air/OrientationManager$EAspectRatio;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EAspectRatio;->ordinal()I

    move-result v0

    if-ne p1, v0, :cond_4

    .line 533
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v0, v3}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 534
    iput v3, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    goto :goto_0

    .line 539
    :cond_4
    const/4 v0, -0x1

    iput v0, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    .line 544
    iget-boolean v0, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    if-ne v0, v2, :cond_1

    .line 546
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_0
.end method

.method public setAutoOrients(Z)V
    .locals 2
    .param p1, "autoOrients"    # Z

    .prologue
    .line 560
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    if-nez v0, :cond_1

    .line 577
    :cond_0
    :goto_0
    return-void

    .line 563
    :cond_1
    iput-boolean p1, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    .line 565
    iget-boolean v0, p0, Lcom/adobe/air/OrientationManager;->mAutoOrients:Z

    const/4 v1, 0x1

    if-ne v0, v1, :cond_3

    .line 567
    iget v0, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    const v1, 0x40533333    # 3.3f

    cmpg-float v0, v0, v1

    if-ltz v0, :cond_2

    iget v0, p0, Lcom/adobe/air/OrientationManager;->mRequestedAspectRatio:I

    const/4 v1, -0x1

    if-ne v0, v1, :cond_0

    .line 569
    :cond_2
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_0

    .line 575
    :cond_3
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_0
.end method

.method public setNearestOrientation(I)V
    .locals 2
    .param p1, "orientation"    # I

    .prologue
    .line 493
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    if-eqz v0, :cond_0

    .line 495
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    if-ne p1, v0, :cond_1

    .line 497
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 512
    :cond_0
    :goto_0
    return-void

    .line 499
    :cond_1
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    if-ne p1, v0, :cond_2

    .line 501
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedLeftOrientation:I

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_0

    .line 503
    :cond_2
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    if-ne p1, v0, :cond_3

    .line 505
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOsRotatedRightOrientation:I

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_0

    .line 507
    :cond_3
    sget-object v0, Lcom/adobe/air/OrientationManager$EOrientation;->UPSIDE_DOWN:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v0}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v0

    if-ne p1, v0, :cond_0

    .line 509
    iget-object v0, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOsReversedOrientation:I

    invoke-virtual {v0, v1}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_0
.end method

.method public setOrientation(I)V
    .locals 6
    .param p1, "orientation"    # I

    .prologue
    const/4 v5, 0x0

    const/4 v4, 0x1

    .line 432
    iget v1, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 434
    .local v1, "beforeOrientation":I
    sget v2, Landroid/os/Build$VERSION;->SDK_INT:I

    const/16 v3, 0x8

    if-le v2, v3, :cond_2

    .line 436
    invoke-virtual {p0, p1}, Lcom/adobe/air/OrientationManager;->setNearestOrientation(I)V

    .line 437
    iput-boolean v4, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    .line 438
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->getCurrentOrientation()I

    move-result v2

    iput v2, p0, Lcom/adobe/air/OrientationManager;->mOrientation:I

    .line 481
    :cond_0
    :goto_0
    invoke-direct {p0}, Lcom/adobe/air/OrientationManager;->getCurrentOrientation()I

    move-result v0

    .line 482
    .local v0, "afterOrientation":I
    iget v2, p0, Lcom/adobe/air/OrientationManager;->mNamespaceVersion:F

    const v3, 0x40733333    # 3.8f

    cmpl-float v2, v2, v3

    if-ltz v2, :cond_1

    if-eq v0, v1, :cond_1

    .line 484
    invoke-virtual {p0, v1, v0}, Lcom/adobe/air/OrientationManager;->nativeOrientationChanged(II)V

    .line 486
    :cond_1
    return-void

    .line 448
    .end local v0    # "afterOrientation":I
    :cond_2
    sget-object v2, Lcom/adobe/air/OrientationManager$EOrientation;->DEFAULT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v2}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v2

    if-ne p1, v2, :cond_4

    .line 450
    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    if-eqz v2, :cond_0

    .line 452
    iget v2, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-ne v2, v4, :cond_3

    .line 454
    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2, v4}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 460
    :goto_1
    iput-boolean v4, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    goto :goto_0

    .line 458
    :cond_3
    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    goto :goto_1

    .line 463
    :cond_4
    sget-object v2, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_RIGHT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v2}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v2

    if-ne p1, v2, :cond_5

    .line 465
    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    if-eqz v2, :cond_0

    iget v2, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-ne v2, v4, :cond_0

    .line 467
    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2, v5}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 468
    iput-boolean v4, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    goto :goto_0

    .line 471
    :cond_5
    sget-object v2, Lcom/adobe/air/OrientationManager$EOrientation;->ROTATED_LEFT:Lcom/adobe/air/OrientationManager$EOrientation;

    invoke-virtual {v2}, Lcom/adobe/air/OrientationManager$EOrientation;->ordinal()I

    move-result v2

    if-ne p1, v2, :cond_0

    .line 473
    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    if-eqz v2, :cond_0

    iget v2, p0, Lcom/adobe/air/OrientationManager;->mOsDefaultOrientation:I

    if-nez v2, :cond_0

    .line 475
    iget-object v2, p0, Lcom/adobe/air/OrientationManager;->m_activity:Landroid/app/Activity;

    invoke-virtual {v2, v4}, Landroid/app/Activity;->setRequestedOrientation(I)V

    .line 476
    iput-boolean v4, p0, Lcom/adobe/air/OrientationManager;->mSetOrientation:Z

    goto :goto_0
.end method
