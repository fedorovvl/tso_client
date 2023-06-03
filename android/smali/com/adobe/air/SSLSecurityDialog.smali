.class public Lcom/adobe/air/SSLSecurityDialog;
.super Ljava/lang/Object;
.source "SSLSecurityDialog.java"


# static fields
.field public static final TAG:Ljava/lang/String;

.field private static final USER_ACTION_TRUST_ALWAYS:Ljava/lang/String; = "always"

.field private static final USER_ACTION_TRUST_NONE:Ljava/lang/String; = "none"

.field private static final USER_ACTION_TRUST_SESSION:Ljava/lang/String; = "session"


# instance fields
.field private m_condition:Ljava/util/concurrent/locks/Condition;

.field private m_lock:Ljava/util/concurrent/locks/Lock;

.field private m_useraction:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .prologue
    .line 35
    const-class v0, Lcom/adobe/air/SSLSecurityDialog;

    invoke-virtual {v0}, Ljava/lang/Class;->toString()Ljava/lang/String;

    move-result-object v0

    sput-object v0, Lcom/adobe/air/SSLSecurityDialog;->TAG:Ljava/lang/String;

    return-void
.end method

.method public constructor <init>()V
    .locals 1

    .prologue
    .line 42
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 210
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_useraction:Ljava/lang/String;

    .line 43
    new-instance v0, Ljava/util/concurrent/locks/ReentrantLock;

    invoke-direct {v0}, Ljava/util/concurrent/locks/ReentrantLock;-><init>()V

    iput-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_lock:Ljava/util/concurrent/locks/Lock;

    .line 44
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_lock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->newCondition()Ljava/util/concurrent/locks/Condition;

    move-result-object v0

    iput-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_condition:Ljava/util/concurrent/locks/Condition;

    .line 45
    return-void
.end method

.method private SetUserAction(Ljava/lang/String;)V
    .locals 1
    .param p1, "action"    # Ljava/lang/String;

    .prologue
    .line 190
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_lock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 191
    iput-object p1, p0, Lcom/adobe/air/SSLSecurityDialog;->m_useraction:Ljava/lang/String;

    .line 192
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_condition:Ljava/util/concurrent/locks/Condition;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Condition;->signal()V

    .line 193
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_lock:Ljava/util/concurrent/locks/Lock;

    invoke-interface {v0}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 194
    return-void
.end method

.method static synthetic access$000(Lcom/adobe/air/SSLSecurityDialog;Ljava/lang/String;)V
    .locals 0
    .param p0, "x0"    # Lcom/adobe/air/SSLSecurityDialog;
    .param p1, "x1"    # Ljava/lang/String;

    .prologue
    .line 32
    invoke-direct {p0, p1}, Lcom/adobe/air/SSLSecurityDialog;->SetUserAction(Ljava/lang/String;)V

    return-void
.end method


# virtual methods
.method public ShowSSLDialog(Ljava/lang/String;[BLandroid/net/http/SslCertificate;Z)V
    .locals 22
    .param p1, "server"    # Ljava/lang/String;
    .param p2, "cert"    # [B
    .param p3, "sslCert"    # Landroid/net/http/SslCertificate;
    .param p4, "showTrustAlwaysButton"    # Z

    .prologue
    .line 63
    invoke-static {}, Lcom/adobe/air/AndroidActivityWrapper;->GetAndroidActivityWrapper()Lcom/adobe/air/AndroidActivityWrapper;

    move-result-object v3

    .line 65
    .local v3, "act":Lcom/adobe/air/AndroidActivityWrapper;
    invoke-virtual {v3}, Lcom/adobe/air/AndroidActivityWrapper;->getActivity()Landroid/app/Activity;

    move-result-object v10

    .line 67
    .local v10, "mainActivity":Landroid/app/Activity;
    if-nez v10, :cond_0

    .line 69
    invoke-virtual {v3}, Lcom/adobe/air/AndroidActivityWrapper;->WaitForNewActivity()Landroid/app/Activity;

    move-result-object v10

    .line 72
    :cond_0
    new-instance v7, Lcom/adobe/air/AndroidAlertDialog;

    invoke-direct {v7, v10}, Lcom/adobe/air/AndroidAlertDialog;-><init>(Landroid/content/Context;)V

    .line 74
    .local v7, "dialog":Lcom/adobe/air/AndroidAlertDialog;
    invoke-virtual {v7}, Lcom/adobe/air/AndroidAlertDialog;->GetAlertDialogBuilder()Landroid/app/AlertDialog$Builder;

    move-result-object v16

    .line 78
    .local v16, "sslDialogBuilder":Landroid/app/AlertDialog$Builder;
    invoke-virtual {v10}, Landroid/app/Activity;->getLayoutInflater()Landroid/view/LayoutInflater;

    move-result-object v9

    .line 80
    .local v9, "inflater":Landroid/view/LayoutInflater;
    invoke-virtual {v10}, Landroid/app/Activity;->getResources()Landroid/content/res/Resources;

    move-result-object v14

    .line 82
    .local v14, "runtimeResources":Landroid/content/res/Resources;
    const-string v19, "ssl_certificate_warning"

    move-object/from16 v0, v19

    invoke-static {v0, v14, v9}, Lcom/adobe/air/utils/Utils;->GetLayoutView(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/LayoutInflater;)Landroid/view/View;

    move-result-object v17

    .line 84
    .local v17, "view":Landroid/view/View;
    if-eqz v17, :cond_2

    .line 86
    invoke-virtual/range {v17 .. v17}, Landroid/view/View;->getResources()Landroid/content/res/Resources;

    move-result-object v18

    .line 87
    .local v18, "viewResources":Landroid/content/res/Resources;
    const-string v19, "ServerName"

    move-object/from16 v0, v19

    move-object/from16 v1, v18

    move-object/from16 v2, v17

    invoke-static {v0, v1, v2}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v15

    check-cast v15, Landroid/widget/TextView;

    .line 88
    .local v15, "serverText":Landroid/widget/TextView;
    new-instance v19, Ljava/lang/StringBuilder;

    invoke-direct/range {v19 .. v19}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v15}, Landroid/widget/TextView;->getText()Ljava/lang/CharSequence;

    move-result-object v20

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v19

    const-string v20, " "

    invoke-virtual/range {v19 .. v20}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    move-object/from16 v0, v19

    move-object/from16 v1, p1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v19

    invoke-virtual/range {v19 .. v19}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v19

    move-object/from16 v0, v19

    invoke-virtual {v15, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;)V

    .line 90
    const/4 v5, 0x0

    .line 91
    .local v5, "certificate":Lcom/adobe/air/Certificate;
    if-eqz p2, :cond_3

    .line 93
    new-instance v5, Lcom/adobe/air/Certificate;

    .end local v5    # "certificate":Lcom/adobe/air/Certificate;
    invoke-direct {v5}, Lcom/adobe/air/Certificate;-><init>()V

    .line 94
    .restart local v5    # "certificate":Lcom/adobe/air/Certificate;
    move-object/from16 v0, p2

    invoke-virtual {v5, v0}, Lcom/adobe/air/Certificate;->setCertificate([B)Ljava/lang/Boolean;

    .line 101
    :goto_0
    const-string v19, "IDA_CERTIFICATE_DETAILS"

    move-object/from16 v0, v19

    invoke-static {v0, v14}, Lcom/adobe/air/utils/Utils;->GetResourceString(Ljava/lang/String;Landroid/content/res/Resources;)Ljava/lang/String;

    move-result-object v6

    .line 103
    .local v6, "certificateDetails":Ljava/lang/String;
    const/16 v19, 0x8

    move/from16 v0, v19

    new-array v0, v0, [Ljava/lang/Object;

    move-object/from16 v19, v0

    const/16 v20, 0x0

    .line 104
    invoke-virtual {v5}, Lcom/adobe/air/Certificate;->getIssuedToCommonName()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    const/16 v20, 0x1

    .line 105
    invoke-virtual {v5}, Lcom/adobe/air/Certificate;->getIssuedToOrganization()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    const/16 v20, 0x2

    .line 106
    invoke-virtual {v5}, Lcom/adobe/air/Certificate;->getIssuedToOrganizationalUnit()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    const/16 v20, 0x3

    .line 107
    invoke-virtual {v5}, Lcom/adobe/air/Certificate;->getIssuedByCommonName()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    const/16 v20, 0x4

    .line 108
    invoke-virtual {v5}, Lcom/adobe/air/Certificate;->getIssuedByOrganization()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    const/16 v20, 0x5

    .line 109
    invoke-virtual {v5}, Lcom/adobe/air/Certificate;->getIssuedByOrganizationalUnit()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    const/16 v20, 0x6

    .line 110
    invoke-virtual {v5}, Lcom/adobe/air/Certificate;->getIssuedOn()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    const/16 v20, 0x7

    .line 111
    invoke-virtual {v5}, Lcom/adobe/air/Certificate;->getExpiresOn()Ljava/lang/String;

    move-result-object v21

    aput-object v21, v19, v20

    .line 103
    move-object/from16 v0, v19

    invoke-static {v6, v0}, Ljava/lang/String;->format(Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v8

    .line 113
    .local v8, "formattedCertificateDetails":Ljava/lang/String;
    const-string v19, "CertificateDetails"

    move-object/from16 v0, v19

    move-object/from16 v1, v18

    move-object/from16 v2, v17

    invoke-static {v0, v1, v2}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v4

    check-cast v4, Landroid/widget/TextView;

    .line 114
    .local v4, "certDetails":Landroid/widget/TextView;
    sget-object v19, Landroid/widget/TextView$BufferType;->SPANNABLE:Landroid/widget/TextView$BufferType;

    move-object/from16 v0, v19

    invoke-virtual {v4, v8, v0}, Landroid/widget/TextView;->setText(Ljava/lang/CharSequence;Landroid/widget/TextView$BufferType;)V

    .line 116
    const-string v19, "NeutralButton"

    move-object/from16 v0, v19

    move-object/from16 v1, v18

    move-object/from16 v2, v17

    invoke-static {v0, v1, v2}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v12

    check-cast v12, Landroid/widget/Button;

    .line 117
    .local v12, "neutralButton":Landroid/widget/Button;
    new-instance v19, Lcom/adobe/air/SSLSecurityDialog$1;

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v7}, Lcom/adobe/air/SSLSecurityDialog$1;-><init>(Lcom/adobe/air/SSLSecurityDialog;Lcom/adobe/air/AndroidAlertDialog;)V

    move-object/from16 v0, v19

    invoke-virtual {v12, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 125
    const-string v19, "PositiveButton"

    move-object/from16 v0, v19

    move-object/from16 v1, v18

    move-object/from16 v2, v17

    invoke-static {v0, v1, v2}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v13

    check-cast v13, Landroid/widget/Button;

    .line 126
    .local v13, "positiveButton":Landroid/widget/Button;
    if-eqz p4, :cond_4

    .line 129
    new-instance v19, Lcom/adobe/air/SSLSecurityDialog$2;

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v7}, Lcom/adobe/air/SSLSecurityDialog$2;-><init>(Lcom/adobe/air/SSLSecurityDialog;Lcom/adobe/air/AndroidAlertDialog;)V

    move-object/from16 v0, v19

    invoke-virtual {v13, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 136
    const/16 v19, 0x0

    move/from16 v0, v19

    invoke-virtual {v13, v0}, Landroid/widget/Button;->setVisibility(I)V

    .line 140
    :goto_1
    const-string v19, "NegativeButton"

    move-object/from16 v0, v19

    move-object/from16 v1, v18

    move-object/from16 v2, v17

    invoke-static {v0, v1, v2}, Lcom/adobe/air/utils/Utils;->GetWidgetInViewByNameFromPackage(Ljava/lang/String;Landroid/content/res/Resources;Landroid/view/View;)Landroid/view/View;

    move-result-object v11

    check-cast v11, Landroid/widget/Button;

    .line 141
    .local v11, "negativeButton":Landroid/widget/Button;
    new-instance v19, Lcom/adobe/air/SSLSecurityDialog$3;

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v7}, Lcom/adobe/air/SSLSecurityDialog$3;-><init>(Lcom/adobe/air/SSLSecurityDialog;Lcom/adobe/air/AndroidAlertDialog;)V

    move-object/from16 v0, v19

    invoke-virtual {v11, v0}, Landroid/widget/Button;->setOnClickListener(Landroid/view/View$OnClickListener;)V

    .line 149
    invoke-virtual/range {v16 .. v17}, Landroid/app/AlertDialog$Builder;->setView(Landroid/view/View;)Landroid/app/AlertDialog$Builder;

    .line 151
    new-instance v19, Lcom/adobe/air/SSLSecurityDialog$4;

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    invoke-direct {v0, v1}, Lcom/adobe/air/SSLSecurityDialog$4;-><init>(Lcom/adobe/air/SSLSecurityDialog;)V

    move-object/from16 v0, v16

    move-object/from16 v1, v19

    invoke-virtual {v0, v1}, Landroid/app/AlertDialog$Builder;->setOnKeyListener(Landroid/content/DialogInterface$OnKeyListener;)Landroid/app/AlertDialog$Builder;

    .line 163
    new-instance v19, Lcom/adobe/air/SSLSecurityDialog$5;

    move-object/from16 v0, v19

    move-object/from16 v1, p0

    invoke-direct {v0, v1, v7}, Lcom/adobe/air/SSLSecurityDialog$5;-><init>(Lcom/adobe/air/SSLSecurityDialog;Lcom/adobe/air/AndroidAlertDialog;)V

    move-object/from16 v0, v19

    invoke-virtual {v10, v0}, Landroid/app/Activity;->runOnUiThread(Ljava/lang/Runnable;)V

    .line 174
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/SSLSecurityDialog;->m_lock:Ljava/util/concurrent/locks/Lock;

    move-object/from16 v19, v0

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->lock()V

    .line 177
    :try_start_0
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/SSLSecurityDialog;->m_useraction:Ljava/lang/String;

    move-object/from16 v19, v0

    if-nez v19, :cond_1

    .line 178
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/SSLSecurityDialog;->m_condition:Ljava/util/concurrent/locks/Condition;

    move-object/from16 v19, v0

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Condition;->await()V
    :try_end_0
    .catch Ljava/lang/InterruptedException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 183
    :cond_1
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/SSLSecurityDialog;->m_lock:Ljava/util/concurrent/locks/Lock;

    move-object/from16 v19, v0

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->unlock()V

    .line 186
    .end local v4    # "certDetails":Landroid/widget/TextView;
    .end local v5    # "certificate":Lcom/adobe/air/Certificate;
    .end local v6    # "certificateDetails":Ljava/lang/String;
    .end local v8    # "formattedCertificateDetails":Ljava/lang/String;
    .end local v11    # "negativeButton":Landroid/widget/Button;
    .end local v12    # "neutralButton":Landroid/widget/Button;
    .end local v13    # "positiveButton":Landroid/widget/Button;
    .end local v15    # "serverText":Landroid/widget/TextView;
    .end local v18    # "viewResources":Landroid/content/res/Resources;
    :cond_2
    :goto_2
    return-void

    .line 98
    .restart local v5    # "certificate":Lcom/adobe/air/Certificate;
    .restart local v15    # "serverText":Landroid/widget/TextView;
    .restart local v18    # "viewResources":Landroid/content/res/Resources;
    :cond_3
    new-instance v5, Lcom/adobe/air/Certificate;

    .end local v5    # "certificate":Lcom/adobe/air/Certificate;
    move-object/from16 v0, p3

    invoke-direct {v5, v0}, Lcom/adobe/air/Certificate;-><init>(Landroid/net/http/SslCertificate;)V

    .restart local v5    # "certificate":Lcom/adobe/air/Certificate;
    goto/16 :goto_0

    .line 138
    .restart local v4    # "certDetails":Landroid/widget/TextView;
    .restart local v6    # "certificateDetails":Ljava/lang/String;
    .restart local v8    # "formattedCertificateDetails":Ljava/lang/String;
    .restart local v12    # "neutralButton":Landroid/widget/Button;
    .restart local v13    # "positiveButton":Landroid/widget/Button;
    :cond_4
    const/16 v19, 0x8

    move/from16 v0, v19

    invoke-virtual {v13, v0}, Landroid/widget/Button;->setVisibility(I)V

    goto :goto_1

    .line 180
    .restart local v11    # "negativeButton":Landroid/widget/Button;
    :catch_0
    move-exception v19

    .line 183
    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/SSLSecurityDialog;->m_lock:Ljava/util/concurrent/locks/Lock;

    move-object/from16 v19, v0

    invoke-interface/range {v19 .. v19}, Ljava/util/concurrent/locks/Lock;->unlock()V

    goto :goto_2

    :catchall_0
    move-exception v19

    move-object/from16 v0, p0

    iget-object v0, v0, Lcom/adobe/air/SSLSecurityDialog;->m_lock:Ljava/util/concurrent/locks/Lock;

    move-object/from16 v20, v0

    invoke-interface/range {v20 .. v20}, Ljava/util/concurrent/locks/Lock;->unlock()V

    throw v19
.end method

.method public getUserAction()Ljava/lang/String;
    .locals 1

    .prologue
    .line 209
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_useraction:Ljava/lang/String;

    return-object v0
.end method

.method public show(Ljava/lang/String;Landroid/net/http/SslCertificate;)Ljava/lang/String;
    .locals 2
    .param p1, "server"    # Ljava/lang/String;
    .param p2, "certificate"    # Landroid/net/http/SslCertificate;

    .prologue
    .line 201
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, v0, p2, v1}, Lcom/adobe/air/SSLSecurityDialog;->ShowSSLDialog(Ljava/lang/String;[BLandroid/net/http/SslCertificate;Z)V

    .line 202
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_useraction:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 206
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_useraction:Ljava/lang/String;

    return-object v0
.end method

.method public show(Ljava/lang/String;[B)Ljava/lang/String;
    .locals 2
    .param p1, "server"    # Ljava/lang/String;
    .param p2, "cert"    # [B

    .prologue
    .line 52
    const/4 v0, 0x0

    const/4 v1, 0x0

    invoke-virtual {p0, p1, p2, v0, v1}, Lcom/adobe/air/SSLSecurityDialog;->ShowSSLDialog(Ljava/lang/String;[BLandroid/net/http/SslCertificate;Z)V

    .line 53
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_useraction:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 57
    :cond_0
    iget-object v0, p0, Lcom/adobe/air/SSLSecurityDialog;->m_useraction:Ljava/lang/String;

    return-object v0
.end method
